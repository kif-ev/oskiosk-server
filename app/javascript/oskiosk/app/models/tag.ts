export class Tag {
    name: string;
    occurrences: number;

    constructor(name: string){
        this.name = name;
    }

    getPlain(){
        return this.name;
    }

    static getTagArrayFromStringArray(s: string[]){
        let result: Tag[] = [];
        for(let item of s){
            result.push(new Tag(item));
        }
        return result;
    }
};
