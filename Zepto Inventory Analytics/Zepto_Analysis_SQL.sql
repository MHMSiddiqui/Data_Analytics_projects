USE zepto_inventory_raw;

SELECT * FROM zepto_v2;
DESCRIBE zepto_v2;
ALTER TABLE zepto_v2
RENAME COLUMN ï»¿Category TO Category;
SELECT COUNT(*) FROM zepto_v2;


-- 1 Dataset exploration

-- 1.1 Dataset overview
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT name) AS distinct_products,
    COUNT(DISTINCT Category) AS total_categories
FROM zepto_v2;
-- 1.2 Inspect the imported data
SELECT *
FROM zepto_v2
LIMIT 20;
-- 1.3 Category assortment
SELECT
    Category,
    COUNT(*) AS listed_products,
    COUNT(DISTINCT name) AS distinct_products
FROM zepto_v2
GROUP BY Category
ORDER BY listed_products DESC;

-- 1.4 Basic price statistics
SELECT
    MIN(mrp) AS minimum_mrp,
    MAX(mrp) AS maximum_mrp,
    ROUND(AVG(mrp), 2) AS average_mrp,
    MIN(discountedSellingPrice) AS minimum_selling_price,
    MAX(discountedSellingPrice) AS maximum_selling_price
FROM zepto_v2;

-- 2 Data quality audit

-- 2.1 Identify missing values
SELECT
    SUM(Category IS NULL OR TRIM(Category) = '') AS missing_categories,
    SUM(name IS NULL OR TRIM(name) = '') AS missing_product_names,
    SUM(mrp IS NULL) AS missing_mrp,
    SUM(discountPercent IS NULL) AS missing_discounts,
    SUM(availableQuantity IS NULL) AS missing_available_quantity,
    SUM(discountedSellingPrice IS NULL) AS missing_selling_price,
    SUM(weightInGms IS NULL) AS missing_weight,
    SUM(outOfStock IS NULL) AS missing_stock_status,
    SUM(quantity IS NULL) AS missing_pack_quantity
FROM zepto_v2;

-- 2.2 Find duplicate-looking products
SELECT
    Category,
    name,
    COUNT(*) AS duplicate_count
FROM zepto_v2
GROUP BY Category, name
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- 2.3 Identify invalid or suspicious values
SELECT *
FROM zepto_v2
WHERE mrp < 0
   OR discountedSellingPrice < 0
   OR discountPercent < 0
   OR discountPercent > 100
   OR availableQuantity < 0
   OR weightInGms < 0
   OR quantity <= 0
   OR (
       mrp > 0
       AND discountedSellingPrice > mrp
   );

-- 2.4 Find products with zero or negative prices
SELECT *
FROM zepto_v2
WHERE mrp <= 0
   OR discountedSellingPrice <= 0;

-- 2.5 Compare stated and calculated discounts
SELECT
    Category,
    name,
    mrp,
    discountedSellingPrice,
    discountPercent AS stated_discount_pct,
    ROUND(
        (mrp - discountedSellingPrice)
        / NULLIF(mrp, 0) * 100,
        2
    ) AS calculated_discount_pct
FROM zepto_v2
WHERE mrp > 0
ORDER BY calculated_discount_pct DESC;

-- 3 Product and Pricing Analysis

-- 3.1 Find the 10 most expensive products
SELECT
    Category,
    name,
    mrp,
    discountedSellingPrice,
    discountPercent
FROM zepto_v2
ORDER BY discountedSellingPrice DESC
LIMIT 10;


-- 3.2 Find the 10 cheapest products
SELECT
    Category,
    name,
    discountedSellingPrice
FROM zepto_v2
WHERE discountedSellingPrice > 0
ORDER BY discountedSellingPrice ASC
LIMIT 10;


-- 3.3 Calculate average selling price by category
SELECT
    Category,
    ROUND(AVG(discountedSellingPrice), 2)
        AS average_selling_price
FROM zepto_v2
GROUP BY Category
ORDER BY average_selling_price DESC;


-- 3.4 Find products with discounts greater than 20%
SELECT
    Category,
    name,
    mrp,
    discountedSellingPrice,
    discountPercent
FROM zepto_v2
WHERE discountPercent > 20
ORDER BY discountPercent DESC;


-- 3.5 Calculate the actual discount from product prices
SELECT
    name,
    mrp,
    discountedSellingPrice,
    discountPercent AS listed_discount_pct,
    ROUND(
        (mrp - discountedSellingPrice)
        / NULLIF(mrp, 0) * 100,
        2
    ) AS calculated_discount_pct
FROM zepto_v2
WHERE mrp > 0
ORDER BY calculated_discount_pct DESC;

-- 4 Inventory and Stock Analysis

-- 4.1 Count products by stock status
SELECT
    outOfStock,
    COUNT(*) AS product_count
FROM zepto_v2
GROUP BY outOfStock;


-- 4.2 List all out-of-stock products
SELECT
    Category,
    name,
    availableQuantity
FROM zepto_v2
WHERE outOfStock = TRUE
ORDER BY Category, name;


-- 4.3 Identify products with low available quantity
-- Example threshold: 1 to 5 units
SELECT
    Category,
    name,
    availableQuantity
FROM zepto_v2
WHERE availableQuantity BETWEEN 1 AND 5
  AND outOfStock = FALSE
ORDER BY availableQuantity ASC;


-- 4.4 Find categories with the most out-of-stock products
SELECT
    Category,
    COUNT(*) AS out_of_stock_products
FROM zepto_v2
WHERE outOfStock = TRUE
GROUP BY Category
ORDER BY out_of_stock_products DESC;


-- 4.5 Calculate the overall out-of-stock percentage
SELECT
    COUNT(*) AS total_products,
    SUM(outOfStock = TRUE) AS out_of_stock_products,
    ROUND(
        100.0 * SUM(outOfStock = TRUE) / COUNT(*),
        2
    ) AS out_of_stock_percentage
FROM zepto_v2;

-- 5 Business Insights and Final Summary

-- 5.1 Overall business summary
SELECT
    COUNT(*) AS total_product_rows,
    COUNT(DISTINCT name) AS unique_products,
    COUNT(DISTINCT Category) AS total_categories,
    ROUND(AVG(discountPercent), 2)
        AS average_discount_percentage,
    ROUND(AVG(mrp), 2) AS average_mrp_source_units,
    ROUND(AVG(discountedSellingPrice), 2)
        AS average_selling_price_source_units,
    SUM(outOfStock = TRUE) AS out_of_stock_products,
    SUM(outOfStock = FALSE) AS available_products
FROM zepto_v2;


-- 5.2 Category-level business summary
SELECT
    Category,
    COUNT(*) AS product_count,
    ROUND(AVG(discountPercent), 2)
        AS average_discount_percentage,
    ROUND(AVG(discountedSellingPrice), 2)
        AS average_selling_price_source_units,
    SUM(outOfStock = TRUE) AS out_of_stock_products
FROM zepto_v2
GROUP BY Category
ORDER BY product_count DESC;


-- 5.3 Find categories with the highest average discounts
SELECT
    Category,
    ROUND(AVG(discountPercent), 2)
        AS average_discount_percentage,
    COUNT(*) AS product_count
FROM zepto_v2
GROUP BY Category
ORDER BY average_discount_percentage DESC
LIMIT 10;


-- 5.4 Find products that are discounted but out of stock
SELECT
    Category,
    name,
    discountPercent,
    discountedSellingPrice,
    availableQuantity
FROM zepto_v2
WHERE discountPercent > 0
  AND outOfStock = TRUE
ORDER BY discountPercent DESC;


-- 5.5 Identify products with high discounts and low availability
SELECT
    Category,
    name,
    discountPercent,
    availableQuantity,
    outOfStock
FROM zepto_v2
WHERE discountPercent >= 20
  AND availableQuantity BETWEEN 1 AND 5
  AND outOfStock = FALSE
ORDER BY discountPercent DESC;