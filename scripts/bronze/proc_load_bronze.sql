CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    BEGIN TRY

        DECLARE @start_time DATETIME;
        DECLARE @end_time DATETIME;
        DECLARE @batch_start_time DATETIME;
        DECLARE @batch_end_time DATETIME;

        SET @batch_start_time = GETDATE();

        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '================================================';


        -- CRM Customer Info
        SET @start_time = GETDATE();

        PRINT 'Truncating table: bronze.crm_cust_info';

        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT 'Loading file: cust_info.csv';

        BULK INSERT bronze.crm_cust_info
        FROM '/tmp/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'Completed: bronze.crm_cust_info';
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';


        -- CRM Product Info
        SET @start_time = GETDATE();

        PRINT 'Truncating table: bronze.crm_prd_info';

        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT 'Loading file: prd_info.csv';

        BULK INSERT bronze.crm_prd_info
        FROM '/tmp/prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'Completed: bronze.crm_prd_info';
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';


        -- CRM Sales Details
        SET @start_time = GETDATE();

        PRINT 'Truncating table: bronze.crm_sales_details';

        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT 'Loading file: sales_details.csv';

        BULK INSERT bronze.crm_sales_details
        FROM '/tmp/sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'Completed: bronze.crm_sales_details';
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';


        -- ERP Customer
        SET @start_time = GETDATE();

        PRINT 'Truncating table: bronze.erp_cust_az12';

        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT 'Loading file: CUST_AZ12.csv';

        BULK INSERT bronze.erp_cust_az12
        FROM '/tmp/CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'Completed: bronze.erp_cust_az12';
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';


        -- ERP Location
        SET @start_time = GETDATE();

        PRINT 'Truncating table: bronze.erp_loc_a101';

        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT 'Loading file: LOC_A101.csv';

        BULK INSERT bronze.erp_loc_a101
        FROM '/tmp/LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'Completed: bronze.erp_loc_a101';
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';


        -- ERP Product Category
        SET @start_time = GETDATE();

        PRINT 'Truncating table: bronze.erp_px_cat_g1v2';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT 'Loading file: PX_CAT_G1V2.csv';

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/tmp/PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'Completed: bronze.erp_px_cat_g1v2';
        PRINT 'Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        

        SET @batch_end_time = GETDATE();
     
        PRINT '================================================';
        PRINT 'Bronze Layer Loading Completed Successfully';
        PRINT '================================================';
        PRINT 'Total Duration for Bronze Layer Loading: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';

    END TRY

    BEGIN CATCH
        PRINT '================================================';
        PRINT 'ERROR OCCURRED';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
        PRINT '================================================';
    END CATCH
END;
EXEC bronze.load_bronze
