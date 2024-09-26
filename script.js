document.addEventListener('DOMContentLoaded', function(){
    document.getElementById("search").oninput = function(){
        var searchterm = document.getElementById("search").value.toLocaleLowerCase()
        var list_items = document.getElementsByClassName("games")
        for (var i = 0; i < list_items.length; i++) {
            var li = list_items[i]
            li.style.display = ""
            if (li.textContent.toLocaleLowerCase().search(searchterm) == -1){
                li.style.display = "none"
            }
        }
    }
})  