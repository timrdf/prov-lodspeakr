function showSubs(){
    var subs = document.getElementById("subs");
    if (subs != null){
        if (subs.style.display == "none"){
        subs.style.display = "block";
            }
        else{
            subs.style.display = "none";
        }
    }
    var subExpand = document.getElementById("subexpand");
    if (subExpand != null){
        if (subExpand.style.display == "none"){
        subExpand.style.display = "inline";
            }
        else{
            subExpand.style.display = "none";
        }
    }
}
