from db_connection import connect_to_postgres
import pandas as pd

def main():
    connection = connect_to_postgres()
    if connection:
        try:
            cursor = connection.cursor()

            # Correct SQL query variable
            postgreSQL_select_Query = 'SELECT * FROM cinema'

            # Execute the query
            cursor.execute(postgreSQL_select_Query)

            # Fetch and debug the results
            rows = cursor.fetchall()
            print("Raw Data:", rows)  # Print raw data to check the query output

            # Convert the data into a Pandas DataFrame
            df = pd.DataFrame(rows, columns=['CinID', 'Name', 'Address', 'Phone', 'Screen_count'])
            print(df)

        except Exception as e:
            print(f"Errorrr: {e}")  # Properly display the error message

        finally:
            # Ensure the cursor and connection are closed
            cursor.close()
            connection.close()
            print("Connection closed.")
    else:
        print("Connection to PostgreSQL failed.")

if __name__ == "__main__":
    main()
