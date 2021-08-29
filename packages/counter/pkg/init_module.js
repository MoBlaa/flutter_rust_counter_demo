import init, {increment as inc, count as cnt} from "./counter_wasm.js"

function increment(val) {
    return inc(val);
}

window.increment = increment;

window.count = () => cnt();

init()
    .then(() => {
        var result = increment(0);
        console.log("Initialized wasm! Testing: 0+1="+result)
    }, (err) => console.error(`Error: ${err}`));