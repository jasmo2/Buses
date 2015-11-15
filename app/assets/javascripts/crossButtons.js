/**
 * Created by jasmo2 on 10/27/15.
 */
function Crossbuttons(obj){
    var buttons = [],
        INSTANCE = this,
        obj = obj;
    INSTANCE.init = function(){
        buttons  = fetchButtonArray(obj.btns);
        assignIndex(buttons,0);
        cross(buttons);
    }
    function cross(buttons){
        for (var i = 0, l = buttons.length; i < l ; i+=1){
            buttons[i].addEventListener('change',function(e){
                assignIndex(buttons,this.selectedIndex);
            })
        }
    }
    function assignIndex(buttons,index){
        for(var i = 0, l = buttons.length; i < l ; i+=1){
           buttons[i]
                .selectedIndex = index;
        }
    }
    function fetchButtonArray(btns){
        var buttons = [];
        for (var i = 0, l = btns.length; i < l ; i+=1){
            buttons.push(document.getElementById(btns[i]))
        }
        return buttons;
    }
} ;