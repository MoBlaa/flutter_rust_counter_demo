import init, {increment as inc} from "./counter_wasm.js"

function increment(val) {
    return inc(val);
}

window.increment = increment;

init()
    .then(() => {
        var result = increment(0);
        console.log("Initialized wasm! Testing: 0+1="+result)
    }, (err) => console.error(`Error: ${err}`));