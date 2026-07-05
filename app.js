const BankingService = require("./services/bankingService");

async function main() {

    try {

        console.log("\n==============================");
        console.log("BANKING MANAGEMENT SYSTEM");
        console.log("==============================");

        //-----------------------------------
        // Customers
        //-----------------------------------

        const customers = await BankingService.getCustomers();

        console.log("\nCustomers");
        console.table(customers);

        //-----------------------------------
        // Accounts Before Transfer
        //-----------------------------------

        console.log("\nAccounts Before Transfer");

        console.table(await BankingService.getAccounts());

        //-----------------------------------
        // Transfer Money
        //-----------------------------------

        console.log("\nTransfering $200...");
        
        await BankingService.transferMoney(
            1,
            2,
            200
        );

        //-----------------------------------
        // Accounts After Transfer
        //-----------------------------------

        console.log("\nAccounts After Transfer");

        console.table(await BankingService.getAccounts());

    }

    catch (error) {

        console.error(error.message);

    }

    finally {

        process.exit();
    }
}

main();