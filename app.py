from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)

# Configuración de la base de datos

app.config['MYSQL_HOST']="localhost"
app.config['MYSQL_USER']="root"
app.config['MYSQL_PASSWORD']=""
app.config['MYSQL_DB']="chacharitaspi"

app.secret_key='mysecretkey'


mysql= MySQL(app)

# Ruta para mostrar todos los clientes
@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM clients")
    clients = cur.fetchall()
    cur.close()
    return render_template('clients/index.html', clients=clients)

# Ruta para agregar un nuevo cliente
@app.route('/clients/add', methods=['POST'])
def add_client():
    if request.method == 'POST':
        name = request.form['name']
        last_name = request.form['last_name']
        email = request.form['email']
        phone_number = request.form['phone_number']
        password = request.form['password']
        id_gender = request.form['id_gender']
        id_address = request.form['id_address']

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO clients (name, last_name, email, phone_number, password, id_gender, id_address) VALUES (%s, %s, %s, %s, %s, %s, %s)", (name, last_name, email, phone_number, password, id_gender, id_address))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('index'))
    
# Vista para mostrar la página de confirmación de eliminación
@app.route("/delete/<int:id>")
def mostrar_confirmacion_eliminacion(id):
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM clients WHERE id = %s', (id,))
    client = cur.fetchone()
    cur.close()
    return render_template('clients/delete.html', clients=client)

# Ruta para eliminar un cliente
@app.route('/deletec/<int:id>', methods=['POST'])
def delete_client(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM subscriptions WHERE id_client = %s", (id,))
    cur.execute("DELETE FROM clients WHERE id = %s", (id,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('index'))

@app.route('/visualizaredit/<string:id>')
def visualizaredit(id):
    cur = mysql.connection.cursor()
    cur.execute('select * from clients where id = %s', (id,))
    clients = cur.fetchone()
    return render_template('/clients/edit.html', clients=clients)

# Ruta para mostrar un cliente específico para edición
@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit_client(id):
    if request.method == 'POST':
        name = request.form['name']
        last_name = request.form['last_name']
        email = request.form['email']
        phone_number = request.form['phone_number']
        password = request.form['password']
        id_gender = request.form['id_gender']
        id_address = request.form['id_address']

        cur = mysql.connection.cursor()
        cur.execute("UPDATE clients SET name = %s, last_name = %s, email = %s, phone_number = %s, password = %s, id_gender = %s, id_address = %s WHERE id = %s", (name, last_name, email, phone_number, password, id_gender, id_address, id))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('index'))
    
    
#Ejecucion de servidor
if __name__ =='__main__':
    app.run(port=3000,debug=True)