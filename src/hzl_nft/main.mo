import CreatorService "CreatorService";
import Debug "mo:base/Debug";
import ExperimentalCycles "mo:base/ExperimentalCycles";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Nft "Nft";
import Prim "mo:prim";
import Principal "mo:base/Principal";
import Result "mo:base/Result";

actor Hub {
    var creatorMap : HashMap.HashMap<Principal, CreatorService.CreatorService> = HashMap.HashMap<Principal, CreatorService.CreatorService>(0, Principal.equal, Principal.hash);
    var nftMap : HashMap.HashMap<Nat, Principal> = HashMap.HashMap<Nat, Principal>(0, Nat.equal, Hash.hash);

    var idCounter : Nat = 0;

    public shared(msg) func requestId() : async Result.Result<Nat, Text> {
        switch(creatorMap.get(msg.caller)) {
            case (?v) {
                idCounter := idCounter + 1;
                return #ok(idCounter);
            };
            case (None) {
                return #err("Invalid Request");
            }
        }
    };

    public shared query func getNftAddress(id : Nat) : async ?Principal {
        return nftMap.get(id);
    };
    
    public shared(msg) func spawnCreator() : async Text {
        let existing = creatorMap.get(msg.caller);

        switch(creatorMap.get(msg.caller)) {
            case (?v) {
                return Principal.toText(Principal.fromActor(v));
            };
            case (None) {
                let new = await CreatorService.CreatorService(msg.caller, Prim.principalOfActor(Hub));
                creatorMap.put(msg.caller, new);
                return Principal.toText(Principal.fromActor(new));
            };
        };

        return "Ok";
    };

    // noop
    public func deposit() : async () {
        let v = ExperimentalCycles.available();
        let _ = ExperimentalCycles.accept(v);
        return;
    };

    public func http_request() : async Text {
        Debug.print("hello World");
        return "ok";
    };
};
