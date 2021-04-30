// NFT Canister
// Is this a good idea? Who knows!
// This canister is designed to 
actor class Nft(creator : Principal, id : Nat, payloadData : [Nat8], payloadDataType : Text) {
    type Data = {
        dataType : Text;
        data : [Nat8]; // We're being lazy pals - sending the data as a Nat8 Array
    };

    var owner : Principal = creator;

    let data : Data = {
        dataType = payloadDataType;
        data = payloadData;
    };

    public shared(msg) func transferOwner(newOwner : Principal) : async () {
        if (msg.caller != owner) {
            return;
        };

        owner := newOwner;
        return;
    };

    public query func getData() : async Data {
        return data;
    };

    public query func getOwner() : async Principal {
        return owner;
    };

    public query func getId() : async Nat {
        return id;
    };
}