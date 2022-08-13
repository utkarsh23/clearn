
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "public";

Clarinet.test({
    name: "Test for performing sum of three numbers",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const sender = accounts.get("wallet_1")!;
        const numOne = 20;
        const numTwo = 35;
        const numThree = 50;
        let block = chain.mineBlock([
            Tx.contractCall(contractName, "sum-three", [
                types.uint(numOne),
                types.uint(numTwo),
                types.uint(numThree),
            ], sender.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        block.receipts[0].result.expectOk().expectUint(numOne + numTwo + numThree);
    },
});
