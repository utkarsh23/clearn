
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

const contractName = "constants";

Clarinet.test({
    name: "Test for verifying the deployer wallet address",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const deployer = accounts.get("deployer")!;
        const receipt = chain.callReadOnlyFn(contractName, "get-deployer-contract", [], deployer.address);
        receipt.result.expectSome().expectPrincipal(deployer.address);
    },
});
