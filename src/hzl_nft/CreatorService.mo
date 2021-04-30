import Nft "Nft";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Types "public_types";

actor class CreatorService(owner : Principal, spawn : Principal) {

    let hub : Types.Hub = actor(Principal.toText(spawn));
    
    public shared(msg) func mintNft(data : [Nat8], dataType : Text) : async Result.Result<Principal, Text> {
        if (msg.caller != owner) {
            return #err("Not Authorized");
        };


        switch(await hub.requestId()) {
            case (#ok(v)) {
                let minted = await Nft.Nft(owner, v, data, dataType);
                return #ok(Principal.fromActor(minted));
            };
            case (#err(e)) {
                return #err(e);
            };
        };

    }
}