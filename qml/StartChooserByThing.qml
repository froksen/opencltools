import QtQuick 2.3
import QtQuick.LocalStorage 2.0

MyTab{
    property int seconds: 10
    property var db: null
    property int latestChoice: -1
    // Default possibilites
    property var defaultsortings: [qsTr("Tallest"),
        qsTr("Lowest"),
        qsTr("Most recently had birthday"),
        qsTr("Largest shoe size"),
        qsTr("Smallest shoe size"),
        qsTr("Longest hair"),
        qsTr("Shortest hair"),
        qsTr("Darkest hair"),
        qsTr("Lightest hair"),
        qsTr("Longest leg"),
        qsTr("Shortest leg"),
        qsTr("Longest indexfinger"),
        qsTr("Shortest indexfinger"),
        qsTr("Longest right arm"),
        qsTr("Shortest right arm"),
        qsTr("Darkest pants"),
        qsTr("Longest indexfinger nail"),
        qsTr("Jump highest"),
        qsTr("Most power left on the cellphone"),
        qsTr("Most curly hair"),
        qsTr("Shortest left foot"),
        qsTr("Widest foot")
    ]


    id: myTab
    headertext: qsTr("Start chooser (Thing)")

    Row{
        anchors.top: topsection.bottom
        width: parent.width
        enabled: dbadmin.visible || cover.visible ? false : true ;

        TouchButton{
            width: parent.width/2
            text: qsTr("Mange options")

            onClicked: {
                dbadmin.visible = true;
                alltoadmindialog()
            }
        }
        TouchButton{
            id: buttonNewchoice
            width: parent.width/2
            text: qsTr("New choice")

            onClicked: {
                blinkingTimer.start();
                seconds = 10;
                cover.visible = true;
                textelement.text = getRandom();

            }
        }
    }

    Rectangle{
        id: cover
        width: parent.width
        height: parent.height-topsection.height
        anchors.bottom: parent.bottom
        color: "#fff";
        z: 1
        visible: false;
        Text{
            anchors.centerIn: parent
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            width: 20
            height: 20
            font.capitalization: Font.AllUppercase
            text: qsTr("choosing")
            font.family: "Helvetica"
            font.pointSize: 25
            color: "white"
        }
    }

    Timer {
        id: blinkingTimer
        interval: 200; running: false; repeat: true;
        onTriggered: {seconds--;
                if(cover.color == "#ffffff"){
                    cover.color = "lightgrey";
                }
                else {
                    cover.color = "#ffffff"
                }

                if(seconds<=0){
                    blinkingTimer.stop();console.log("Timer stopped"); cover.visible = false;
                }
                else {
                    cover.visible = true;
                }
            }
    }

    Text{
        id: textelement
        anchors.fill: parent
        font.family: "Helvetica"
        font.pointSize: parent.width/lengthofstring(textelement.text)
        color: "black"
        horizontalAlignment: TextInput.AlignHCenter
        text: qsTr("Push the button '%1'").arg(buttonNewchoice.text)
        verticalAlignment: TextInput.AlignVCenter
        wrapMode: Text.Wrap
    }

    ListModel {
        id: sortingsmodel
    }

    DatabaseAdministration{
        id: dbadmin
        anchors.centerIn: parent;
        contentmodel: sortingsmodel

        onForceupdate: {
            openDB();
            alltoadmindialog()
        }
    }

    function lengthofstring(str){
        var n = str.length;
        return n;
    }
    function openDB() {
        if(db !== null) return;

        // db = LocalStorage.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
        db = LocalStorage.openDatabaseSync("CLToolsDB", "1.0", "Database for CL Tools", 1000000);

        try {
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS startbythings(text TEXT)');
                var table  = tx.executeSql("SELECT * FROM startbythings");
                // Seed the table with default values
                if (table.rows.length == 0) {
                    console.log('No records found!');
                    restoreDefaults()
                };

                //Printer alle mulighederne ud
                var rs = tx.executeSql('SELECT * FROM startbythings');
                console.log("*ALLE MULIGHEDER*");
                for(var i = 0; i < rs.rows.length; i++) {
                    console.log("- "+rs.rows.item(i).text)
                }
            });
        } catch (err) {
            console.log("Error creating table in database: " + err);
        };
    }

    function alltoadmindialog(){
        openDB();
        db.transaction( function(tx){
            sortingsmodel.clear()
            var rs = tx.executeSql('SELECT * FROM startbythings');
            for(var i = 0; i < rs.rows.length; i++) {
                sortingsmodel.append({"text":rs.rows.item(i).text})
            }
        })
    }

    function insertOreplace(text) {
        openDB();
        db.transaction( function(tx){
            tx.executeSql('INSERT OR REPLACE INTO startbythings VALUES(?)', [text]);
        });
   }

    function getSetting(key) {
        openDB();
        var res = "";
        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT value FROM settings WHERE text=?;', [key]);
            res = rs.rows.item(0).value;
        });
        return res;
    }

    function deleteKey(key){
        openDB();
        //var res = "";
        db.transaction(function(tx) {
            var rs = tx.executeSql('DELETE FROM startbythings WHERE text=?;', [key]);

            console.log("Removing " + key)
            //Mangler at lægge noget validering ind her.
            return true;


            //res = rs.rows.item(0).value;
        });
       // return res;
    }

    function deleteTable(){
        openDB();
        var res = "";
        db.transaction(function(tx) {
            var rs = tx.executeSql("DROP TABLE startbythings")
            console.log("table deleted");
        });
    }

    function restoreDefaults(){
        openDB();
        var res = "";
        console.log("**Restoring to defaults**");
        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT * FROM startbythings');
            console.log("*Removing old instances*");
            for(var i = 0; i < rs.rows.length; i++) {
                tx.executeSql('DELETE FROM startbythings WHERE text=?',rs.rows.item(i).text)
                console.log("- Removing: "+rs.rows.item(i).text)
            }

            console.log("*Inserting default instances*");
            for(var index = 0; index < defaultsortings.length; index++) {
                tx.executeSql('INSERT INTO startbythings VALUES(?)', defaultsortings[index]);
                console.log("- Inserting: "+defaultsortings[index])
            }
        });
        console.log("**Restoring complete**");
    }


     function getRandom(){
         openDB();
         var res = "";
         db.transaction(function(tx) {
             var rs = tx.executeSql('SELECT * FROM startbythings');

             console.log ("*Getting random number*")
             console.log("- Number of possibilities: "+rs.rows.length)

             var randnumber = Math.floor(Math.random() * rs.rows.length) + 1;

             console.log("- First choice: " + rs.rows.item(randnumber-1).text + " (Index: " + randnumber + ")");

             var failsafe = 0
             while(latestChoice == randnumber){
                 randnumber = Math.floor(Math.random() * rs.rows.length) + 1;
                 console.log("- Used last time, trying with " + rs.rows.item(randnumber-1).text + " (Index: " + randnumber + ")" + " instead");
                 if(failsafe >=50){
                     console.log ("- Uable to find new number, continueing to prevent freezing..")
                     break;
                 }
                 failsafe++
             }

             console.log("- Final choice: "+ rs.rows.item(randnumber-1).text + " (Index: " + randnumber + ")")

             latestChoice = randnumber;

             res = rs.rows.item(randnumber-1).text;
         });
         return res;
     }

}
