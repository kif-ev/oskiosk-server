import { Component, OnInit } from "@angular/core";
import { Product, Tag, Identifier, Pricing } from "../models";
import { BackendService } from "../services/backend.service";
import { Parser } from "csv-parse";

@Component({
    selector: 'product-import',
    template: require('../templates/product-import.html'),
    providers: []
})
export class ProductImportComponent implements OnInit{

    fileReader: FileReader;
    fileParser: Parser;
    importableProducts: Product[];
    importProgress: number;

    constructor(
        private backendService: BackendService
    ) { }

    ngOnInit() {
        this.fileReader = new FileReader();
        this.fileReader.onloadend = () => { this.onFileRead() };

        this.fileParser = new Parser({delimiter: ","});
        this.fileParser.on("readable", () => { this.onFileReadable() });

        this.importableProducts = [];

        this.importProgress = 0;
    }

    fileEventListener(event: any) {
        this.fileReader.readAsText(event.target.files[0]);
    }

    onFileRead(){
        this.fileParser.write(this.fileReader.result);
    }

    onFileReadable(){
        let record:String[];
        while(record = this.fileParser.read()){
            let product: Product = new Product(
                null,
                <string> record[0],
                Tag.getTagArrayFromStringArray(record[2].split(" ")),
                [new Identifier(<string> record[3])],
                [new Pricing(null, Number(record[1]), 999999)]
            );
            this.importableProducts.push(product);
        }
    }

    confirmImport(){
        let importCount = 0;
        for(let item of this.importableProducts){
            this.backendService.saveProduct(item)
            .subscribe(
                product => {
                    (item as any).import_success = true;
                    importCount++;
                    this.importProgress = importCount / this.importableProducts.length * 100;
                },
                error => {
                    (item as any).import_fail = true;
                    console.log(error);
                    importCount++;
                    this.importProgress = importCount / this.importableProducts.length * 100;
                }
            );
        }
    }

    abortImport(){
        this.importableProducts = [];
    }
}
