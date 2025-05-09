<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .calculator {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .screen {
            width: 100%;
            height: 50px;
            font-size: 24px;
            text-align: right;
            margin-bottom: 10px;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .buttons {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 10px;
        }
        .buttons button {
            font-size: 18px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f7f7f7;
            cursor: pointer;
        }
        .buttons button:hover {
            background-color: #e0e0e0;
        }
        .buttons button:active {
            background-color: #ccc;
        }
        .buttons button.clear {
            background-color: #ff6347;
            color: white;
        }
        .buttons button.equals {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>

<div class="calculator">
    <input type="text" id="screen" class="screen" disabled/>
    
    <div class="buttons">
        <button onclick="clearScreen()" class="clear">C</button>
        <button onclick="appendToScreen('(')"> ( </button>
        <button onclick="appendToScreen(')')"> ) </button>
        <button onclick="appendToScreen('/')"> / </button>
        
        <button onclick="appendToScreen('7')"> 7 </button>
        <button onclick="appendToScreen('8')"> 8 </button>
        <button onclick="appendToScreen('9')"> 9 </button>
        <button onclick="appendToScreen('*')"> * </button>
        
        <button onclick="appendToScreen('4')"> 4 </button>
        <button onclick="appendToScreen('5')"> 5 </button>
        <button onclick="appendToScreen('6')"> 6 </button>
        <button onclick="appendToScreen('-')"> - </button>
        
        <button onclick="appendToScreen('1')"> 1 </button>
        <button onclick="appendToScreen('2')"> 2 </button>
        <button onclick="appendToScreen('3')"> 3 </button>
        <button onclick="appendToScreen('+')"> + </button>
        
        <button onclick="appendToScreen('0')"> 0 </button>
        <button onclick="appendToScreen('.')"> . </button>
        <button onclick="calculateResult()" class="equals"> = </button>
        <button onclick="appendToScreen('sqrt(')"> sqrt </button>
    </div>
</div>

<script>
    function clearScreen() {
        document.getElementById("screen").value = "";
    }

    function appendToScreen(value) {
        document.getElementById("screen").value += value;
    }

    function calculateResult() {
        var screen = document.getElementById("screen");
        var expression = screen.value;
        
        try {
            // Handle advanced operations like sqrt
            if (expression.includes('sqrt')) {
                expression = expression.replace('sqrt', 'Math.sqrt');
            }

            // Evaluate the expression safely
            var result = eval(expression);  // eval is used here, but you could implement a safer evaluator if needed

            screen.value = result;
        } catch (e) {
            screen.value = 'Error';
        }
    }
</script>

</body>
</html>
