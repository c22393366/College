import psycopg2
import os

def connect_to_postgres():
	try:
		connection = psycopg2.connect(database=os.getenv("DB_NAME", "postgres"), user=os.getenv("DB_USER", "C22393366"), password = os.getenv("DB_PASS", "C22393366"), host = os.getenv("DB_HOST", "147.252.250.51"), port = os.getenv("DB_PORT", 5432))
		print("Connection Successful")
		return connection

	except Exception as e:
		print(f"Errorrr: {e}")
		return None