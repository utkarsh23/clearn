
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "maps";

Clarinet.test({
    name: "Test for performing set & get on map: orders",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const sender = accounts.get("wallet_1")!;
        const orderOneAmount = 10;
        let block = chain.mineBlock([
            Tx.contractCall(contractName, "set-order-one", [types.uint(orderOneAmount)], sender.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        const receipt = chain.callReadOnlyFn(contractName, "order-one", [], sender.address);
        const orderDetails = receipt.result.expectSome().expectTuple() as any;
        orderDetails["orderAmount"].expectUint(orderOneAmount);
    },
});

Clarinet.test({
    name: "Test for performing set & get on map: highest-bids",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const sender = accounts.get("wallet_1")!;
        const bidId = 20;
        let block = chain.mineBlock([
            Tx.contractCall(contractName, "set-highest-bids", [], sender.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        const receipt = chain.callReadOnlyFn(contractName, "get-highest-bids", [], sender.address);
        const bidDetails = receipt.result.expectSome().expectTuple() as any;
        bidDetails["bid-id"].expectUint(bidId);
    },
});
