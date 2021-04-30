import hzl_nft from 'ic:canisters/hzl_nft';

hzl_nft.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
