from selenium import webdriver
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
#import csv
import pandas as pd

# Ensure ChromeDriverManager installs the ChromeDriver binary
ChromeDriverManager().install() # linked to driver

# Initialize an empty list to store elements
element_list = []

# Iterate through pages
for page in range(1, 3):  # Pages 1 and 2

    page_url = f"https://doomlings.com/collections/all?page={page}"

    # Create a new instance of WebDriver for Chrome
    driver = webdriver.Chrome()

    # Get the page
    driver.get(page_url)

    # Find all elements with the class 'product-block__title-link', 'theme_money', and 'yotpo-sr-bottom-line-text'
    titles = driver.find_elements(By.CLASS_NAME, "product-block__title-link")
    prices = driver.find_elements(By.CLASS_NAME, "theme_money")
    ratings = driver.find_elements(By.CLASS_NAME, "yotpo-sr-bottom-line-text")

    # Check if all lists have the same number of elements
    num_titles = len(titles)
    num_prices = len(prices)
    num_ratings = len(ratings)

    # Ensure all lists have the same number of elements
    min_length = min(num_titles, num_prices, num_ratings)

    # Iterate through each element found and append it to the element list
    for i in range(min_length):
        cleaned_price = prices[i].text.replace("€", "").replace(",", ".")
        cleaned_price = float(cleaned_price)

        # Clean up reviews format: extract only the numeric part
        cleaned_reviews = ratings[i].text.split()[0]  # Assumes format is "<number> reviews"
        cleaned_reviews = int(cleaned_reviews)
        
        element_list.append([titles[i].text, cleaned_price, cleaned_reviews])

    # Close the driver after processing the page
    driver.quit()

# Convert element_list to a Pandas DataFrame
df = pd.DataFrame(element_list, columns=["Title", "Price", "Reviews"])

# Save DataFrame to Excel
excel_filename = "scraped_doomlings_data.xlsx"
df.to_excel(excel_filename, index=False)

print(f"Data saved to {excel_filename}")


    
'''
    
def get_price(element):
    return float(element[1].replace('€', '').replace(',', '.'))

# Print the collected data
element_list.sort(key = get_price)
for each in element_list:
    print(each)
    
max_reviews = max(element_list, key=lambda x: int(x[2].split()[0]))
print("\nThe Product with the most reviews:")
print(f"Title: {max_reviews[0]}")
print(f"Price: {max_reviews[1]}")
print(f"Reviews: {max_reviews[2]}")
'''
