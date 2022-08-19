
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "unwrap";

Clarinet.test({
    name: "Test for unwrapping a listing ID from the listings map.",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const deployer = accounts.get("deployer")!;
        const listing_id = 1;
        const updated_name = "New Listing";
        let block = chain.mineBlock([
            Tx.contractCall(contractName, "update-name", [types.uint(listing_id), types.ascii(updated_name)], deployer.address)
        ]);
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        block.receipts[0].result.expectOk().expectBool(true);
        const listing = chain.callReadOnlyFn(contractName, "get-listing", [types.uint(listing_id)], deployer.address).result.expectSome().expectTuple() as any;
        listing["name"].expectAscii(updated_name);
    },
});
