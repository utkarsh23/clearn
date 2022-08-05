
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "variables";

Clarinet.test({
    name: "Test for verifying the sender wallet address",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const sender = accounts.get("wallet_1")!;
        const score = 200;
        let block = chain.mineBlock([
            Tx.contractCall(contractName, "set-high-score", [types.uint(score)], sender.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        const receipt = chain.callReadOnlyFn(contractName, "get-high-score", [], sender.address);
        const highScoreDetails = receipt.result.expectSome().expectTuple() as any;
        highScoreDetails["who"].expectSome().expectPrincipal(sender.address);
    },
});

Clarinet.test({
    name: "Test for performing set & get on variable: high-score",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const sender = accounts.get("wallet_1")!;
        const score = 200;
        let block = chain.mineBlock([
            Tx.contractCall(contractName, "set-high-score", [types.uint(score)], sender.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        const receipt = chain.callReadOnlyFn(contractName, "get-high-score", [], sender.address);
        const highScoreDetails = receipt.result.expectSome().expectTuple() as any;
        highScoreDetails["score"].expectUint(score);
    },
});
