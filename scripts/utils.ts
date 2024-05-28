import fs from "fs";
import path from "path";

export function getContracts(network: string): ContractAddresses {
    let json: string;
    try {
        const env: string = process.env.NODE_ENV || '';
        json = fs.readFileSync(
            path.join(
                __dirname,
                `../deployed-contracts/${env}.contract-addresses.json`
            )
        ).toString(); // Convert Buffer to string
    } catch (err) {
        json = "{}";
    }
    const addresses: ContractAddresses = JSON.parse(json);
    return addresses;
}

interface ContractAddresses {
    [network: string]: {
        [contract: string]: string;
    };
}

export function saveContract(network: string, contract: string, address: string): void {
    const env: string = process.env.NODE_ENV || '';

    const addresses: ContractAddresses = getContracts(network);
    addresses[network] = addresses[network] || {};
    addresses[network][contract] = address;
    fs.writeFileSync(
        path.join(
            __dirname,
            `../deployed-contracts/${env}.contract-addresses.json`
        ),
        JSON.stringify(addresses, null, "    ")
    );
}
