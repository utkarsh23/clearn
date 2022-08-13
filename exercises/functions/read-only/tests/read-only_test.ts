
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "read-only";

Clarinet.test({
    name: "Test for fetching the deployer's counter value",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const deployer = accounts.get("deployer")!;
        const counter = 55;
        const receipt = chain.callReadOnlyFn(contractName, "get-my-counter", [], deployer.address);
        receipt.result.expectSome().expectUint(counter);
    },
});
