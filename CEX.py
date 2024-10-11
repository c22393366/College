from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import StaleElementReferenceException, TimeoutException, NoSuchElementException, ElementClickInterceptedException
from webdriver_manager.chrome import ChromeDriverManager
import pandas as pd
import time

# Ensure ChromeDriverManager installs the ChromeDriver binary
ChromeDriverManager().install()

# Initialize an empty list to store elements
element_list = []

# Maximum number of retries for stale element errors
max_retries = 3

# Create a new instance of WebDriver for Chrome
driver = webdriver.Chrome()

try:
    # Navigate to the Gaming Categories page
    categories_url = "https://ie.webuy.com/supercat?superCatId=1&superCatName=Gaming"
    driver.get(categories_url)

    # Wait for the categories to load
    WebDriverWait(driver, 15).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, ".section-spacing.image-card-grid"))
    )

    # Find all category elements
    category_elements = driver.find_elements(By.CSS_SELECTOR, ".cx-image-card-img a")

    # Extract the URLs for each category
    category_urls = [category.get_attribute('href') for category in category_elements]

    # Iterate through each category
    for category_url in category_urls:
        driver.get(category_url)
        page_number = 1

        while True:
            try:
                # Wait for the page to load and the elements to be present
                WebDriverWait(driver, 15).until(
                    EC.presence_of_element_located((By.CSS_SELECTOR, ".card-title a"))
                )

                # Find all product link elements inside the 'card-title' div
                product_wrappers = driver.find_elements(By.CSS_SELECTOR, ".card-title a")

                if not product_wrappers:
                    print(f"No products found on page {page_number} of category {category_url}.")
                    break

                print(f"Found {len(product_wrappers)} products on page {page_number} of category {category_url}.")  # Debugging

                # Iterate through each product found
                for i, wrapper in enumerate(product_wrappers):
                    retries = 0
                    while retries < max_retries:
                        try:
                            # Re-locate the element just before interacting with it
                            wrapper = driver.find_elements(By.CSS_SELECTOR, ".card-title a")[i]
                            product_link = wrapper.get_attribute('href')

                            # Navigate to the product page
                            driver.get(product_link)

                            # Wait for the product detail elements to load
                            sell_price_element = WebDriverWait(driver, 15).until(
                                EC.presence_of_element_located((By.CSS_SELECTOR, ".sell-price.md-mb-0.d-block.w-100"))
                            )
                            buy_price_element = WebDriverWait(driver, 15).until(
                                EC.presence_of_element_located((By.CSS_SELECTOR, "p.text-sm.md-text-base.w-100 .body-s-medium.grey-1000-color.mr-xs"))
                            )

                            sell_price = float(sell_price_element.text.replace("€", "").replace(",", "."))
                            buy_price = float(buy_price_element.text.replace("€", "").replace(",", "."))

                            # Extract the product title using the correct selector
                            title_element = driver.find_element(By.CSS_SELECTOR, "h1")
                            title = title_element.text

                            print(f"Title: {title}, Sell Price: {sell_price}, Buy Price: {buy_price}")  # Debugging

                            # Append the data to the list
                            element_list.append([title, sell_price, buy_price])

                            # Exit the retry loop if successful
                            break

                        except (StaleElementReferenceException, TimeoutException, NoSuchElementException) as e:
                            print(f"Retrying due to error: {e}")
                            retries += 1
                            if retries >= max_retries:
                                print(f"Failed to process product after {max_retries} attempts: {e}")
                                break
                            time.sleep(2)  # Wait before retrying

                        finally:
                            # Go back to the search results page
                            driver.back()
                            WebDriverWait(driver, 15).until(EC.presence_of_element_located((By.CSS_SELECTOR, ".card-title a")))

                # Check if there is a "Next Page" link and click it
                try:
                    next_page = driver.find_element(By.CSS_SELECTOR, "a.ais-Pagination-link[aria-label='Next Page']")
                    next_page.click()
                    page_number += 1

                    # Wait for the new page to load
                    WebDriverWait(driver, 15).until(
                        EC.presence_of_element_located((By.CSS_SELECTOR, ".card-title a"))
                    )
                except NoSuchElementException:
                    print(f"Reached the last page of category {category_url}.")
                    break
                except ElementClickInterceptedException:
                    print("Click on 'Next Page' intercepted. Handling the overlay...")
                    try:
                        # Attempt to close the overlay if it exists
                        overlay_close_button = driver.find_element(By.CSS_SELECTOR, ".onetrust-close-btn-handler")
                        overlay_close_button.click()

                        # Retry clicking the "Next Page" button
                        next_page.click()
                    except NoSuchElementException:
                        print("Overlay close button not found, moving to next page...")
                        time.sleep(2)  # Small delay before retrying
                    except Exception as e:
                        print(f"Failed to handle the overlay: {e}")
                        break

            except Exception as e:
                print(f"An error occurred in category {category_url}: {e}")
                break

finally:
    # Close the driver after processing all categories
    driver.quit()

# Convert element_list to a Pandas DataFrame
df = pd.DataFrame(element_list, columns=["Title", "Sell Price", "Buy Price"])

# Save DataFrame to Excel
excel_filename = "cex_gaming_prices_data.xlsx"
df.to_excel(excel_filename, index=False)

print(f"Data saved to {excel_filename}")
