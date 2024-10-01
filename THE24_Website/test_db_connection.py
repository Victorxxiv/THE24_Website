import psycopg2
from psycopg2 import sql

try:
    connection = psycopg2.connect(
        user="VictorTHE24",
        password="Apple[24]",
        host="victordb-1.c382m86yovsf.eu-north-1.rds.amazonaws.com",
        port="5432",
        database="victordb-1"
    )
    cursor = connection.cursor()
    cursor.execute("SELECT current_database();")
    db_name = cursor.fetchone()
    print(f"Connected to database: {db_name[0]}")

except Exception as e:
    print(f"Error: {e}")

finally:
    if connection:
        cursor.close()
        connection.close()
