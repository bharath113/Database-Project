import MySQLdb

def connection():
    conn = MySQLdb.connect(host="localhost",
                           user = "root",
                           passwd="",
                           db= "mydb")
    c = conn.cursor()
    return c, conn