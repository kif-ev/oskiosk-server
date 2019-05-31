import { KeyCodeMap } from "./keycodes";

export class GlobalInput {
    onKeyDownEvent(e: KeyboardEvent): void {
        let literal: string = KeyCodeMap.getLiteral(e.keyCode);
        if(literal){
            this.onLiteralInput(literal);
        }
        else{
            this.onSpecialKeyInput(e.keyCode);
        }
    }

    // Magic fat arrow to keep "this" reference intact
    keyEventProxy = (e: KeyboardEvent): void => {
        this.onKeyDownEvent(e);
    }
   
    startCaptureInput(): void {
        document.addEventListener('keydown', this.keyEventProxy, false);
    }

    stopCaptureInput(): void {
        document.removeEventListener('keydown', this.keyEventProxy, false);
    }

    onLiteralInput(literal: string): void{
        throw Error('Not implemented!');
    }

    onSpecialKeyInput(keyCode: number): void{
        throw Error('Not implemented!');
    }
}