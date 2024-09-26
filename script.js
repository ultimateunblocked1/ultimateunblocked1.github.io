document.addEventListener('DOMContentLoaded', function(){
    document.getElementById("search").oninput = function () {
        var searchterm = document.getElementById("search").value.toLocaleLowerCase();
        var list_items = document.querySelectorAll("li");
        for (var i = 0; i < list_items.length; i++) {
            var li = list_items[i];
            if (li.textContent.toLocaleLowerCase().search(searchterm) == -1) {
                li.style.display = "none";
            } else {
                li.style.display = "";
            }
        }
    };
});