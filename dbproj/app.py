from flask import flash, Flask, redirect, render_template, request, session, url_for
from wtforms import *
from dbconnect import connection
from passlib.hash import sha256_crypt
from MySQLdb import escape_string as thwart
from functools import wraps
from random import randint
from datetime import datetime
import time
import gc,os

app=Flask(__name__)
app.secret_key = 'super secret key'

APP_ROOT = os.path.dirname(os.path.abspath(__file__))

class data_desc():
    label = "LABEL"
    item_data = "Item data"
    item_cost= "$2.00"
    img_name = "2"


    
@app.route("/")
def index():
    #session.clear()
    c, conn = connection()
    sql = """ select i.*,l.GameName from iteminfo i, games l where i.GameId=l.GameId order by i.ItemPrice"""
    data_basic = c.execute(sql)
    data_basic = c.fetchmany(4)
    
    #data = ["LABEL","ITEM DATA","ITEM COST","2"]
    sql1=""" select * from games """
    game_data = c.execute(sql1)
    game_data = c.fetchall()

    data=data_basic
    #select distinct ItemNo from items where ItemId in (select distinct ItemId from transcation order by time);
    sql ="select g.GameName,ii.ItemName,ii.ItemPrice,i.ItemNo from items i,transcation t,games g,iteminfo ii where i.ItemId in (select ItemId from transcation order by time ) and t.ItemId=i.ItemId and g.GameId = ii.GameId and ii.ItemNo=i.ItemNo group by ii.ItemName order by t.time desc;"
    recent = c.execute(sql)
    recent = c.fetchmany(5)



    c.close()
    conn.close
    gc.collect()
    return render_template("index.html",data=data,game_data=game_data,recent=recent)

@app.route("/Login_page")
def Login_page():
    if 'logged_in' in session:
        return redirect(url_for("user_profile"))
    else:
        return redirect(url_for("login"))#render_template("login.html")

def login_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args, **kwargs)
        else:
            flash("You need to log in")
            return redirect(url_for('register_page'))
        
    return wrap
        

@app.route("/logout")
@login_required
def logout():
    session.clear()
    flash("You have been logedout")
    gc.collect()
    return redirect(url_for('Login_page'))

class registrationform(Form):
	username = TextField('Username',[validators.Length(min=4, max=20)])
	firstname = TextField('First Name', [validators.Required(),validators.Length(min=1, max=20)])
	lastname = TextField('Last Name', [validators.Required(),validators.Length(min=1, max=20)])
	country = TextField('Country', [validators.Required(),validators.Length(min=2, max=20)])
	phone = IntegerField('Phone Number', [validators.Required()])
	email = TextField('Email',[validators.Length(min=6, max=32)])
	password = PasswordField('Password',[validators.Required(),
										 validators.EqualTo('confirm', message="Passwords do not match"),
										 validators.Length(min=1, max=32)])
	confirm = PasswordField('Repeat Password')


@app.route("/login", methods=['GET','POST'])
def login():
    if 'logged_in' in session:
        error = "You need to logout first"
        return redirect(url_for("index"))
    else:
        error = ''
        try:
            c, conn = connection()
            if request.method == "POST":
                username = request.form['username']
                error=username
                data = c.execute("select * from users where UserName='"+ username +"'") #%s",thwart(username))
                
                data = str(c.fetchone()[8])
            
                if request.form['password'] == data:
                    session['logged_in'] = True
                    session['username'] = request.form['username']
                
                    flash("logged successfully")
                    return redirect(url_for("user_profile"))
                else:
                    error="invalid crdentials"
            gc.collect()
            return render_template("login.html",error=error)
        
        except Exception as e:
            return render_template("login.html",error=error)

 
@app.route("/user_profile")
def user_profile():
    if 'logged_in' in session:
        c, conn = connection()
        sql = "select * from users where UserName='"+session['username']+"'"
        user_details = c.execute(sql)
        user_details = c.fetchone()
        sql="select ItemNo from items where UserId = (select UserId from users where UserName='"+session['username']+"')"
        data=c.execute(sql)
        data=c.fetchall()
        return render_template("user_profile.html",user_details=user_details,data=data)
    else:
        error1="You need to login first"#flash("You need to login first")
        return render_template("login.html",error1=error1)#redirect(url_for("Login_page"))

@app.route("/upload_profpic",methods=["GET","POST"])
def upload_profpic():
    if request.method=="POST":    
        target = os.path.join(APP_ROOT,'images')
        if not os.path.isdir(target):
            os.mkdir(target)
       
        if file in request.form.getlist("prof_pic"):
            filename = file.filename
            destination = "/".join([target,filename])
            files.save(destination)
        return render_template("user_profile.html")
    return rendertemplate("prof_pic.html")


@app.route("/edit_profile",methods=["GET","POST"])
def edit_profile():
    c, conn = connection()
    sql = "select * from users where UserName = '"+ session['username']+"'"
    profile_data = c.execute(sql)
    profile_data = c.fetchone()
    c.close()
    conn.close()
    gc.collect()
    return render_template("edit_profile.html",profile_data=profile_data)

@app.route("/change_password",methods=["GET","POST"])
def change_password():
    if request.method=="POST":
        c, conn = connection()
        sql="select Password from users where UserName = '"+session['username']+"' "
        passw=c.execute(sql)
        passw=c.fetchone()[0]
        oldp=request.form['oldPassword']
        newp=request.form['newPassword']
        newr=request.form['newPasswordrepeat']
        error="Wrong Password"
        if passw!=oldp:
            return render_template("change_password.html",error=error)
        if newp!=newr:
            error="The two new passwords does not match"
            return render_template("change_password.html",error=error)
        sql="update users set Password = '"+newp+"' where UserName='"+session['username']+"' "
        c.execute(sql)
        conn.commit()
        c.close()
        conn.close()
        gc.collect()
        return redirect(url_for("user_profile"))
    return render_template("change_password.html")

@app.route("/add_balance",methods=["GET","POST"])
def add_balance():
    c, conn = connection()
    if request.method == "POST":
        bal = request.form['balance']
        sql = " update users set Balance = Balance+"+str(bal)+" where UserName='"+session['username']+"' "
        c.execute(sql)
        conn.commit()
        c.close()
        conn.close()
        gc.collect()
        return redirect(url_for("user_profile"))
    return render_template("balance.html")

@app.route("/profile_save_changes",methods=["GET","POST"])
def profile_save_changes():
    try:
        if request.method == "POST":
            firstname = request.form['firstname']
            lastname = request.form['lastname']
            phone = request.form['phone']
            country = request.form['country']
            summary = request.form['summary']
            
            c, conn = connection()
            sql = "update users set FirstName='"+firstname+"',LastName='"+lastname+"',Phone='"+phone+"',Country='"+country+"', Description='"+summary+"' where UserName = '"+session['username']+"'"
            c.execute(sql)
            conn.commit()
            c.close()
            conn.close()
            gc.collect()
            return redirect(url_for("user_profile")) 
    except Exception as e:
		return(str(e))    
        
@app.route("/register", methods=["GET","POST"])
def register_page():
    error=0
    #try:
    form = registrationform(request.form)
    error=0
    if request.method=="POST":# and form.validate():
		username = request.form['username']#form.username.data
		firstname = request.form['firstname']#form.firstname.data
		lastname = request.form['lastname']#form.lastname.data
		country = request.form['country']#form.country.data
		phone = request.form['phone']#form.phone.data
		email = request.form['email']#form.email.data
		#password = sha256_crypt.encrypt((str(form.password.data)))
		password = request.form['password']#form.password.data
		c, conn = connection()
			
		x = c.execute("""SELECT * FROM users WHERE UserName = %s""", [thwart(username)])
		
		if int(x) > 0:
			error=1#flash("Username is alreay taken.")
			return render_template('register.html', error=error)
		else:
		    c.execute("INSERT INTO users(UserName, FirstName, LastName, Phone, Country, Email, Password) VALUES (%s, %s, %s, %s, %s, %s, %s)",(thwart(username), thwart(firstname), thwart(lastname), thwart(str(phone)), thwart(country), thwart(email), thwart(password)))
		    conn.commit()
		    flash("Thank you for registering.")
		    c.close()
		    conn.close()		
		    gc.collect()
		
		    session['logged_in'] = True
		    session['username'] = username
		
		    return redirect(url_for("user_profile"))
			#return redirect(url_for('user_profile'))
    error=0
    return render_template("register.html", form=form)
	
    #except Exception as e:
	#	return(str(e))


@app.route("/item_data_page/<itemid>", methods=["GET","POST"])
def item_data_page(itemid):
    if request.method=="GET":
        c, conn = connection()
        
        sql="select * from iteminfo where itemNo='"+itemid+"'"
        item_info = c.execute(sql)
        item_info = c.fetchone()
        gameid=str(item_info[9])
        
        sql="select gameName from games where GameId = '"+ gameid +"'"
        item_game_name=c.execute(sql)
        item_game_name=c.fetchone()[0]
        
        sql="select UserName,UserId from users where UserId in (select UserId from items where itemNo="+itemid+") "
        item_no=c.execute(sql)
        item_owner=c.fetchall()

        # Mapping
        
        # SQL commands
        rarity = "select ItemRarity from G" + gameid + " where Number = " + str(item_info[2])
        quality = "select ItemQuality from G" + gameid + " where Number = " + str(item_info[3])
        category = "select ItemCategory from G" + gameid + " where Number = " + str(item_info[7])
        
        # execution and storing the results to a var
        r1 = c.execute(rarity)
        if r1==0:
            r=""
        else:
            r = c.fetchone()[0]
        
        q1 = c.execute(quality)
        if q1==0:
            q=""
        else:
            q = c.fetchone()[0]

        cq1 = c.execute(category)
        if cq1==0:
            cq=""
        else:
            cq = c.fetchone()[0]

        if item_no==0:
            item_no=1
            return render_template("game_info.html",r=r,q=q,cq=cq,item_info=item_info,item_game_name=item_game_name,item_no=item_no)
       
        sql= "select i.ForSale,t.UserName from items i,users t where i.UserId in ( select UserId from users where UserId in (select UserId from items where itemNo="+itemid+") ) and ItemNo='"+itemid+"' and t.UserId=i.UserId and i.ForSale=1"
        
        forsale = c.execute(sql)
        forsale = c.fetchall()
        
       

        c.close()
        conn.close
        gc.collect()
        return render_template("game_info.html",item_info=item_info,item_game_name=item_game_name,item_owner=item_owner,forsale=forsale,r=r,q=q,cq=cq)


@app.route("/trans_page/<item_owner>,<itemid>")
def trans_page(item_owner,itemid):
    c, conn= connection()
    if 'logged_in' in session:
        usernames = [session['username'],item_owner]
       
        sql="select * from iteminfo where itemNo='"+itemid+"'"
        item_info = c.execute(sql)
        item_info = c.fetchone()
        gameid=str(item_info[9])
        
        sql="select gameName from games where GameId = '"+ gameid +"'"
        item_game_name=c.execute(sql)
        item_game_name=c.fetchone()[0]
        
        c.close()
        conn.close
        gc.collect()

        return render_template("transaction.html",usernames=usernames,item_game_name=item_game_name,item_info=item_info)
    else:
        return "loggin first"

@app.route("/transaction/<seller>:<buyer>:<item_no>")
def transaction(seller,buyer,item_no):
    c, conn = connection()
    
    sql="select a.Balance,b.Balance from users a,users b where a.UserName='"+seller+"' and b.UserName='"+buyer+"'"
    money = c.execute(sql)
    money = c.fetchone()
    
    sql="select ItemPrice,GameId from iteminfo where ItemNo='"+item_no+"'"
    cost=c.execute(sql)
    cost=c.fetchone()

    sql="select UserId from users where UserName='"+buyer+"'"
    idb = c.execute(sql)
    idb = c.fetchone()[0]
       
    sql="select UserId from users where UserName='"+seller+"'"
    ids = c.execute(sql)
    ids = c.fetchone()[0]
    
    sql="select GameId from iteminfo where ItemNo ="+item_no+" "
    gameid = c.execute(sql)
    gameid = c.fetchone()[0]
   
    sql="select ForSale from items where UserId="+str(ids)+" and ItemNo="+str(item_no)+" "
    forsale=c.execute(sql)
    forsale=c.fetchone()[0]
   
    if ids==idb:
        c.close()
        conn.close()
        gc.collect()
        return "You can not buy your Items"

    if money[1]>=cost[0] and forsale==1:
        sql="update users set Balance = "+str(money[1]-cost[0])+" where UserName='"+buyer+"' "
        temp=c.execute(sql)
        conn.commit()
       
        sql="update users set Balance = '"+str(money[0]+cost[0])+"' where UserName='"+seller+"' "
        temp=c.execute(sql)
        conn.commit()
        trans = randint(123542,9999999) + randint(0,100000)
       
        
        sql = "select ItemId from items where UserId="+str(ids)+" and ItemNo="+str(item_no)+" "
        itemid=c.execute(sql)
        itemid=c.fetchone()[0]
        
        sql="Insert into transcation(TransId,SellerId,BuyerId,ItemId,SalePrice,Time,GameId) values(%s,%s,%s,%s,%s,%s,%s) " 
        time1=datetime.today()
        c.execute(sql,(trans,ids,idb,itemid,cost[0],time1,gameid))
        conn.commit()
        
        sql="update items set ForSale=0, UserId=(select UserId from users where UserName='"+session['username']+"') where UserId="+str(ids)+" and ItemNo="+str(item_no)+" and ItemId="+str(itemid)+""
        c.execute(sql)
        conn.commit()
        
        c.close()
        conn.close()
        gc.collect()
        return "<a href="+"/user_profile"+">Transaction Done</a>"
        
    else:
        c.close()
        conn.close()
        gc.collect()
        return "Not Done"
    return "ok"    

@app.route("/game_items/<game_id>")
def game_items(game_id):
    c, conn = connection()
    #sql=" select * from items i inner join iteminfo o on i.ItemNo = o.ItemNo where i.ForSale=1 and o.GameId="+game_id+" "
    sql =" select * from iteminfo where GameId="+game_id+" "
    rows = c.execute(sql)
    gameitems = c.fetchall()
    if rows>0:
        rows=0
    else:
        rows=1
    sql="select GameName from games where GameId="+game_id+""
    game_name=c.execute(sql)
    game_name=c.fetchone()[0]
    
    if rows==0:
        c.close()
        conn.close()
        gc.collect()
        return render_template("game_items.html",gameitems=gameitems,game_name=game_name)
    else:
        sql="select GameId from games where GameName='"+game_name+"'"
        gameid = c.execute(sql)
        gameid = c.fetchone()[0]
        return render_template("game_items_no.html",game_name=game_name,gameid=gameid)


@app.route("/sell_items",methods=["GET","POST"])
def sell_items():
    c, conn = connection()
    sql="select i.ItemNo,i.ItemName,i.ItemPrice,g.GameName,ii.ItemId from iteminfo i,games g,items ii where i.GameId=g.GameId and i.ItemNo in (select ItemNo from items where UserId = (select UserId from users where UserName='"+session['username']+"' and ForSale=0)) and ii.ItemNo=i.ItemNo and ii.ForSale=0"
    data=c.execute(sql)
    data=c.fetchall()
    c.close()
    conn.close()
    gc.collect()
    var=1
    return render_template("sell_items.html",data=data,var=var)

@app.route("/remove")
def remove():
    c, conn = connection()
    sql="select i.ItemNo,i.ItemName,i.ItemPrice,g.GameName,ii.ItemId from iteminfo i,games g,items ii where i.GameId=g.GameId and i.ItemNo in (select ItemNo from items where UserId = (select UserId from users where UserName='"+session['username']+"' and ForSale=1)) and ii.ItemNo=i.ItemNo and ii.ForSale=1"
    data=c.execute(sql)
    data=c.fetchall()
    c.close()
    conn.close()
    gc.collect()
    var=0
    return render_template("sell_items.html",data=data,var=var)

@app.route("/remove_from_market/<itemid>")
def remove_from_market(itemid):
    c, conn = connection()
    sql="update items set ForSale = 0 where ItemId="+itemid+" "
    c.execute(sql)
    conn.commit()
    c.close()
    conn.close()
    gc.collect()
    return redirect(url_for("user_profile"))



@app.route("/sell_this/<itemno>:<itemid>")
def sell_this(itemno,itemid):
    c, conn = connection()
    sql= "update items set ForSale = 1 where ItemNo="+itemno+" and ItemId="+itemid+"  "
    c.execute(sql)
    conn.commit()
    c.close()
    conn.close()
    gc.collect()
    return redirect(url_for("user_profile"))

@app.route("/history/<stat>")
def history(stat):
    c, conn = connection()
    sql="select UserId from users where UserName ='"+session['username']+"' "
    userid = c.execute(sql)
    userid = c.fetchone()[0]
    if stat == "1":
        sql="select * from transcation where SellerId=(select UserId from users where UserName ='"+session['username']+"') "
        data =c.execute(sql)
        data = c.fetchall()
        

        sql=" select t.TransId,t.Time,t.SalePrice,i.ItemName,g.GameName,i.ItemNo from items ii,iteminfo i,games g, transcation t where i.ItemNo in (select ItemNo from items where ItemId in(select ItemId from transcation where SellerId = "+str(userid)+")) and g.GameId=i.GameId and t.SellerId="+str(userid)+" and t.ItemId=ii.ItemId and ii.ItemNo=i.ItemNo "
        data1=c.execute(sql)
        data1=c.fetchall()
        return render_template("history.html",data1=data1)
    if stat == "2":
        sql="select * from transcation where SellerId=(select UserId from users where UserName ='"+session['username']+"') "
        data =c.execute(sql)
        data = c.fetchall()

        sql=" select t.TransId,t.Time,t.SalePrice,i.ItemName,g.GameName,i.ItemNo from iteminfo i,games g, transcation t,items ii where i.ItemNo in (select ItemNo from items where ItemId in(select ItemId from transcation where BuyerId = "+str(userid)+")) and g.GameId=i.GameId and t.BuyerId="+str(userid)+" and t.ItemId=ii.ItemId and ii.ItemNo=i.ItemNo"
        data1=c.execute(sql)
        data1=c.fetchall()
        return render_template("history.html",data1=data1)

if __name__ == "__main__":
	app.run(debug=True)