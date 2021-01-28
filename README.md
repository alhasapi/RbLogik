# RbLogik

Take any logical expression written in the prefix-notation like "(and a (or b (eq z k)))" then 
generate a truth table accordingly.
For example:
```bash
bash$ ruby Evaluator.rb
Herbrand > (and a (or b (eq z k)))
 ____ _____ _____ _____ _____ 
|    |     |     |     |     |
|  0 |   0 |   0 |   0 |   0 |
|____|_____|_____|_____|_____|
|    |     |     |     |     |
|  0 |   0 |   0 |   1 |   0 |
|____|_____|_____|_____|_____|
|    |     |     |     |     |
|  0 |   0 |   1 |   0 |   0 |
|____|_____|_____|_____|_____|
|    |     |     |     |     |
|  0 |   0 |   1 |   1 |   0 |
|____|_____|_____|_____|_____|
|    |     |     |     |     |
|  0 |   1 |   0 |   0 |   0 |
|____|_____|_____|_____|_____|
|    |     |     |     |     |
|  0 |   1 |   0 |   1 |   0 |
|____|_____|_____|_____|_____|
.
.
.
.
```
