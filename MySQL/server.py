import pymysql
from flask import Flask, request, jsonify, render_template
from flaskext.mysql import MySQL

app = Flask(__name__)
mysql = MySQL()

# ================= MYSQL CONFIG =================
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
app.config['MYSQL_DATABASE_DB'] = 'emp'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

mysql.init_app(app)

# ================= HOME =================
@app.route("/")
def hello():
    return "Flask API Running..."

# ================= INSERT =================
@app.route('/create', methods=['POST'])
def create_emp():
    conn = None
    cursor = None
    try:
        data = request.json

        name = data['name']
        email = data['email']
        phone = data['phone']
        address = data['address']
        age = data['age']
        major = data['major']

        conn = mysql.connect()
        cursor = conn.cursor()

        sql = """INSERT INTO emp
                 (name,email,phone,address,age,major)
                 VALUES(%s,%s,%s,%s,%s,%s)"""

        cursor.execute(sql, (name,email,phone,address,age,major))
        conn.commit()

        return jsonify({"message":"Insert Success"}), 201

    except Exception as e:
        return jsonify({"error":str(e)}),500

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

# ================= GET ALL =================
@app.route('/emp', methods=['GET'])
def get_emp():
    conn = mysql.connect()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    cursor.execute("SELECT * FROM emp")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(rows)

# ================= UPDATE =================
@app.route('/update/<int:id>', methods=['PUT'])
def update_emp(id):
    conn = None
    cursor = None
    try:
        data = request.json

        name = data['name']
        email = data['email']
        phone = data['phone']
        address = data['address']
        age = data['age']
        major = data['major']

        conn = mysql.connect()
        cursor = conn.cursor()

        sql = """UPDATE emp
                 SET name=%s,email=%s,phone=%s,address=%s,
                     age=%s,major=%s
                 WHERE id=%s"""

        cursor.execute(sql,(name,email,phone,address,age,major,id))
        conn.commit()

        return jsonify({"message":"Update Success"}),200

    except Exception as e:
        return jsonify({"error":str(e)}),500

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

# ================= DELETE =================
@app.route('/delete/<int:id>', methods=['DELETE'])
def delete_emp(id):
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM emp WHERE id=%s",(id,))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message":"Delete Success"})

# ================= RUN =================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5300, debug=True)
