function loadModal() {
    let modalList = document.getElementsByClassName("modal");
    let btnShowList = document.getElementsByClassName("showModal");
    let btnHideList = document.getElementsByClassName("hideModal");

    function show(i){
        modalList[i].style.display = "block";
        btnShowList[i].style.display = "none";
        btnHideList[i].style.display = "block";
    }
    function hide(i){
        modalList[i].style.display = "none";
        btnShowList[i].style.display = "block";
        btnHideList[i].style.display = "none";
    }

    function hideAll(){
        for(let i=0;i<modalList.length; i++){
            modalList[i].style.display = "none";
            btnShowList[i].style.display = "block";
            btnHideList[i].style.display = "none";
        }
    }
    window.onclick = function(event) {
        if (modalList.includes(event.target)) {
            hideAll();
        }
    }

    for (let i = 0; i < btnShowList.length; i++) {
        btnShowList[i].addEventListener("click",()=>show(i));
        btnHideList[i].addEventListener("click", ()=>hide(i));
    }
}