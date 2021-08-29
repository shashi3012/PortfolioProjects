/* 

Cleaning Data In SQL Queries 

*/

SELECT *
FROM Portfolioproject..['NashvilleHousing']


--Standardise Date Format

SELECT SaleDateConverted, CONVERT (Date,SaleDate)
FROM Portfolioproject..['NashvilleHousing']

UPDATE Portfolioproject..['NashvilleHousing']
SET SaleDate =  CONVERT (Date,SaleDate)

ALTER TABLE PortfolioProject..['NashvilleHousing']
ADD SaleDateConverted Date;

UPDATE Portfolioproject..['NashvilleHousing']
SET SaleDateConverted = CONVERT (Date,SaleDate)


--Populate Property Address Data
SELECT *
FROM Portfolioproject..['NashvilleHousing']
--WHERE PropertyAddress is NULL
ORDER BY ParcelID;

SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Portfolioproject..['NashvilleHousing'] a
JOIN Portfolioproject..['NashvilleHousing'] b
   ON a.ParcelID=b.ParcelId
   AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL    

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Portfolioproject..['NashvilleHousing'] a
JOIN Portfolioproject..['NashvilleHousing'] b
   ON a.ParcelID=b.ParcelId
   AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL ;  


--Breaking out address into individual columns (Address, City, State)

SELECT PropertyAddress
FROM Portfolioproject..['NashvilleHousing']
--WHERE PropertyAddress is NULL
--ORDER BY ParcelID;

SELECT 
SUBSTRING(PropertyAddress,1, CHARINDEX (',',PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress,CHARINDEX (',',PropertyAddress)+1 ,LEN(PropertyAddress)) AS Address

FROM Portfolioproject..['NashvilleHousing']

ALTER TABLE PortfolioProject..['NashvilleHousing']
ADD PropertySplitAddress Nvarchar(255);

UPDATE Portfolioproject..['NashvilleHousing']
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX (',',PropertyAddress)-1)

ALTER TABLE PortfolioProject..['NashvilleHousing']
ADD PropertySplitCity Nvarchar(255);


SELECT *
FROM Portfolioproject..['NashvilleHousing']

SELECT OwnerAddress
FROM Portfolioproject..['NashvilleHousing']

SELECT
PARSENAME(REPLACE(OwnerAddress,',' , '.'),3),
PARSENAME(REPLACE(OwnerAddress,',' , '.'),2),
PARSENAME(REPLACE(OwnerAddress,',' , '.'),1)
FROM Portfolioproject..['NashvilleHousing'];

ALTER TABLE PortfolioProject..['NashvilleHousing']
ADD OwnerSplitAddress Nvarchar(255);

UPDATE Portfolioproject..['NashvilleHousing']
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',' , '.'),3)

ALTER TABLE PortfolioProject..['NashvilleHousing']
ADD OwnerSplitCity Nvarchar(255);

UPDATE Portfolioproject..['NashvilleHousing']
SET OwnerSplitCity= PARSENAME(REPLACE(OwnerAddress,',' , '.'),2)

ALTER TABLE PortfolioProject..['NashvilleHousing']
ADD OwnerSplitState Nvarchar(255);

UPDATE Portfolioproject..['NashvilleHousing']
SET OwnerSplitState= PARSENAME(REPLACE(OwnerAddress,',' , '.'),1)

SELECT *
FROM Portfolioproject..['NashvilleHousing']

--Change Y and N to Yes and No in 'Sold as Vacant' field

SELECT DISTINCT (SoldAsVacant),COUNT(SoldAsVacant)
FROM Portfolioproject..['NashvilleHousing']
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant,
   CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END
FROM Portfolioproject..['NashvilleHousing'];

UPDATE Portfolioproject..['NashvilleHousing']
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END;

--Remove Duplicates

WITH RowNumCTE AS  (
SELECT *,
  ROW_NUMBER() OVER (
  PARTITION BY ParcelID,
               PropertyAddress,
			   SaleDate,
			   SalePrice,
			   LegalReference
			   ORDER BY
			     UniqueID
				 ) row_num

FROM Portfolioproject..['NashvilleHousing']
--ORDER BY ParcelId
)
SELECT *
FROM RowNumCTE 
WHERE row_num > 1
ORDER BY PropertyAddress;
  

-- Delete Unused Columns

SELECT *
FROM Portfolioproject..['NashvilleHousing']

ALTER TABLE Portfolioproject..['NashvilleHousing']
DROP COLUMN PropertyAddress,OwnerAddress,TaxDistrict;

ALTER TABLE Portfolioproject..['NashvilleHousing']
DROP COLUMN SaleDate;