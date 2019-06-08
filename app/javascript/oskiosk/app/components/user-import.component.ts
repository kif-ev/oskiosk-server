import { Component, OnInit } from "@angular/core";
import { User, Tag, Identifier } from "../models";
import { BackendService } from "../services/backend.service";
import { Parser } from "csv-parse";

@Component({
    selector: 'user-import',
    template: require('../templates/user-import.html'),
    providers: []
})
export class UserImportComponent implements OnInit{

    fileReader: FileReader;
    fileParser: Parser;
    importableUsers: User[];
    importProgress: number;

    constructor(
        private backendService: BackendService
    ) { }

    ngOnInit() {
        this.fileReader = new FileReader();
        this.fileReader.onloadend = () => { this.onFileRead() };

        this.fileParser = new Parser({delimiter: ","});
        this.fileParser.on("readable", () => { this.onFileReadable() });

        this.importableUsers = [];

        this.importProgress = 0;
    }

    fileEventListener(event: any) {
        this.fileReader.readAsText(event.target.files[0]);
    }

    onFileRead(){
        this.fileParser.write(this.fileReader.result);
        this.fileParser.end();
    }

    onFileReadable(){
        let record:String[];
        while(record = this.fileParser.read()){
            console.log('Parsing: ' + record);
            let user:User = new User(
                null,
                <string> record[0],
                0,
                record[1] != "0",
                Tag.getTagArrayFromStringArray(record[2].split(" ")),
                [new Identifier(<string> record[3])]
            );
            this.importableUsers.push(user);
        }
    }

    confirmImport(){
        let importCount = 0;
        for(let item of this.importableUsers){
            this.backendService.saveUser(item)
            .subscribe(
                user => {
                    (item as any).import_success = true;
                    importCount++;
                    this.importProgress = importCount / this.importableUsers.length * 100;
                },
                error => {
                    (item as any).import_fail = true;
                    console.log(error);
                    importCount++;
                    this.importProgress = importCount / this.importableUsers.length * 100;
                }
            );
        }
    }

    abortImport(){
        this.importableUsers = [];
    }
}
