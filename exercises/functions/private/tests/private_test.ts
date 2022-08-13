
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "private";

Clarinet.test({
    name: "Test for validating if public function caller is the deployer",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const deployer = accounts.get("deployer")!;
        const recipient = accounts.get("wallet_1")!;
        const amt = 300
        let block = chain.mineBlock([
            Tx.contractCall(contractName, "add-recipient", [types.principal(recipient.address), types.uint(amt)], deployer.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        block.receipts[0].result.expectOk().expectBool(true);
    },
});
