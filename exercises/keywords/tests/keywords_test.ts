
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "keywords";

Clarinet.test({
    name: "Test for performing addition on block-height",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const sender = accounts.get("wallet_1")!;
        const addBlockBy = 64;
        const blockHeight = chain.mineBlock([]).height;
        const receipt = chain.callReadOnlyFn(contractName, "get-block-height", [], sender.address);
        receipt.result.expectSome().expectUint(blockHeight + addBlockBy);
    },
});
