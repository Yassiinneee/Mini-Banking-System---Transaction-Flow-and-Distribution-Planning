const pool = require("../config/db");

class BankingService {

    // ---------------------------------------
    // Get all customers
    // ---------------------------------------
    static async getCustomers() {

        const [rows] = await pool.query(`
            SELECT *
            FROM Customers
            ORDER BY customer_id
        `);

        return rows;
    }

    // ---------------------------------------
    // Get all accounts
    // ---------------------------------------
    static async getAccounts() {

        const [rows] = await pool.query(`
            SELECT
                account_id,
                account_number,
                account_type,
                balance
            FROM Accounts
        `);

        return rows;
    }

    // ---------------------------------------
    // Account Balance
    // ---------------------------------------
    static async getBalance(accountId) {

        const [rows] = await pool.query(
            `
            SELECT balance
            FROM Accounts
            WHERE account_id = ?
            `,
            [accountId]
        );

        return rows[0];
    }

    // ---------------------------------------
    // Money Transfer
    // Uses Pessimistic Locking
    // ---------------------------------------
    static async transferMoney(fromAccount, toAccount, amount) {

        const connection = await pool.getConnection();

        try {

            await connection.beginTransaction();

            //----------------------------------
            // Lock Sender Account
            //----------------------------------

            const [sender] = await connection.query(
                `
                SELECT *
                FROM Accounts
                WHERE account_id = ?
                FOR UPDATE
                `,
                [fromAccount]
            );

            //----------------------------------
            // Lock Receiver Account
            //----------------------------------

            const [receiver] = await connection.query(
                `
                SELECT *
                FROM Accounts
                WHERE account_id = ?
                FOR UPDATE
                `,
                [toAccount]
            );

            if (sender.length === 0)
                throw new Error("Sender account not found.");

            if (receiver.length === 0)
                throw new Error("Receiver account not found.");

            if (sender[0].balance < amount)
                throw new Error("Insufficient balance.");

            //----------------------------------
            // Withdraw
            //----------------------------------

            await connection.query(
                `
                UPDATE Accounts
                SET balance = balance - ?
                WHERE account_id = ?
                `,
                [amount, fromAccount]
            );

            //----------------------------------
            // Deposit
            //----------------------------------

            await connection.query(
                `
                UPDATE Accounts
                SET balance = balance + ?
                WHERE account_id = ?
                `,
                [amount, toAccount]
            );

            //----------------------------------
            // Save Transaction
            //----------------------------------

            await connection.query(
                `
                INSERT INTO Transactions
                (
                    sender_account,
                    receiver_account,
                    amount,
                    transaction_type
                )
                VALUES (?, ?, ?, 'Transfer')
                `,
                [fromAccount, toAccount, amount]
            );

            await connection.commit();

            console.log("Transfer completed successfully.");

        } catch (error) {

            await connection.rollback();

            console.log("Transaction rolled back.");

            throw error;

        } finally {

            connection.release();
        }
    }
}

module.exports = BankingService;