First run the follwing script to install the core dependencies

```sh
./run.sh
```

then you may run the following command to install other groups of dependencies

```bash
uv run pyinfra @local docker.py hashicorp_vault.py nvim.py personal.py streaming.py
```
