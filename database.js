function openDB() {
    if(db !== null) return;

    // db = LocalStorage.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
    db = LocalStorage.openDatabaseSync("CLToolsDB", "1.0", "Database for CL Tools", 1000000);

    try {
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS sortings(text TEXT)');
            var table  = tx.executeSql("SELECT * FROM sortings");
            // Seed the table with default values
            if (table.rows.length == 0) {
                tx.executeSql('INSERT INTO sortings VALUES(?)', ["Laveste"]);
                tx.executeSql('INSERT INTO sortings VALUES(?)', ["Højeste"]);
                tx.executeSql('INSERT INTO sortings VALUES(?)', ["Senest fødselsdag"]);
                tx.executeSql('INSERT INTO sortings VALUES(?)', ["Største skostørrelse"]);
                console.log('sortings table added');
            };

            //Printer alle mulighederne ud
            var rs = tx.executeSql('SELECT * FROM sortings');
            console.log("*ALLE MULIGHEDER*");
            for(var i = 0; i < rs.rows.length; i++) {
                console.log("- "+rs.rows.item(i).text)
            }
        });
    } catch (err) {
        console.log("Error creating table in database: " + err);
    };
}


function saveSetting(key, value) {
    openDB();
    db.transaction( function(tx){
        tx.executeSql('INSERT OR REPLACE INTO settings VALUES(?, ?)', [key, value]);
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

function deleteTable(){
    openDB();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql("DROP TABLE sortings")
    });
}
