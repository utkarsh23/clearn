
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "asserts";

Clarinet.test({
    name: "Test for asserting that the function caller is the deployer.",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const deployer = accounts.get("deployer")!;
        const wallet_1 = accounts.get("wallet_1")!;
        const amt = 300
        let block = chain.mineBlock([
            Tx.contractCall(contractName, "add-recipient", [types.principal(wallet_1.address), types.uint(amt)], wallet_1.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        block.receipts[0].result.expectErr().expectUint(1);
        block = chain.mineBlock([
            Tx.contractCall(contractName, "add-recipient", [types.principal(wallet_1.address), types.uint(amt)], deployer.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 3);
        block.receipts[0].result.expectOk().expectBool(true);
    },
});
