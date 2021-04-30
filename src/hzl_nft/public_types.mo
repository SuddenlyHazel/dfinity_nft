import Result "mo:base/Result";
module {
    public type Hub = actor {
        requestId : shared() -> async Result.Result<Nat, Text>;
    }
}