# EDA_Analysis_T3
  
Template 3 for an EDA Analysis that could be called by the EDA_Builder.  
   
Support is provided for a default configPath; If the configFile is not  
found at configPath, then the base name provided in configPath will be   
searched for in the repository at config/[configFile].   
  
This repository includes options to create a report based on a `workflow.rmd`  
or a *`workflow.qmd`* file that can be run by the EDA_Builder script.  
Example templates are provided for each of these workflows.  
  
This is a template repository and can be used to start a new project.  

## Files:
- `build.sh`: The main script that runs the analysis.  
- `src/workflow.Rmd`: The analysis code (placeholder).
- `src/workflow.qmd`: The analysis code (placeholder).
- `config/config.yml`

## Usage

This project can be built from the command line using:  
./build.sh --configPath "config/config.yml"  
or, to test default config location failover:
./build.sh --configPath "nonexistent_dir/config.yml" 

## Workflow explanation:  

The build.sh script is can be executed by a user to "build" the analysis.    
The build.sh can also be executed by the EDA_Builder.sh script which can be used   
to coordinate the building of multiple analyses at once.  The build.sh script reads  
the --configPath argument, runs the workflow.Rmd/qmd, and ensures that the analysis  
code executes properly.  

The user must uncomment one of the two lines, depending on whether they are 
implementing a workflow using R-markdown or quarto:  
  
`Rscript -e "rmarkdown::render('src/workflow.Rmd', params = list(configPath = '$configPath'))"`  
or  
`quarto render src/workflow.qmd --to html -P configPath="$configPath"`  
  
If the analysis script runs without errors, the build.sh   
script creates an output directory outside the repository (two levels up) and places  
a success file there and moves the final html reports to the same directory.  
This setup ensures that the repository meets all the  
requirements to be compatible with the EDA_Builder.sh script.  

## Functionality of the example workflow.Rmd/workflow.qmd

The **workflow** (`workflow.Rmd` / `workflow.qmd`) provides a simple data analysis  
that includes operations that will be common to many workflows:   

1. **Reading a Configuration File**  
   - Loads a `config.yml` file to extract parameters, including:  
     - `input_path`: Path to a dataset (`mtcars.csv`).  
     - `k`: A numeric constant.  
     - `s`: A string message.  
     - `boolean_value`: A logical flag.  

2. **Reading a Secondary Dataset**  
   - Looks for a `current.txt` file in the `test` directory.  
   - Extracts the first line (a CSV filename).  
   - Loads the corresponding dataset into a data frame.  

3. **Processing and Analysis**  
   - Prints the extracted parameters.  
   - If `boolean_value` is `TRUE`, scales the `mpg` column by `k`.  

4. **Visualization and Output**  
   - Generates an **interactive Plotly boxplot** of `mpg` grouped by `cyl`.  
   - Displays the contents of the dataset specified in `current.txt` as an interactive table.  

This workflow ensures **flexibility and reproducibility** by dynamically adjusting to different input files and parameters. Let me know if you need a more detailed description!

## Differences between Rmd and qmd work

The major differences between the **R Markdown (`.Rmd`)** and **Quarto (`.qmd`)** workflows are:

### 1. **File Format and Syntax**
   - **R Markdown (`.Rmd`)**: Uses **R-specific** syntax and integrates tightly with **knitr**.
   - **Quarto (`.qmd`)**: Supports **multiple languages** (R, Python, Julia, and Observable JS) and integrates with Jupyter kernels.

### 2. **Rendering Engine**
   - **R Markdown**: Uses `rmarkdown::render()` and **knitr** for processing.
   - **Quarto**: Uses `quarto render`, which is a more generalized engine supporting multiple languages.

### 3. **Metadata and YAML Header**
   - **R Markdown (`.Rmd`)**:
     ```yaml
     ---
     title: "Workflow Report"
     author: "Your Name"
     date: "`r Sys.Date()`"
     output: html_document
     params:
       configPath: ""
     ---
     ```
     - Requires `r` inline code (`r Sys.Date()`) for dynamic values.
     - The `output` format is **specific to R Markdown** (`html_document`, `pdf_document`, etc.).

   - **Quarto (`.qmd`)**:
     ```yaml
     ---
     title: "Workflow Report"
     author: "Your Name"
     date: today
     format: html
     execute:
       freeze: auto
     params:
       configPath: ""
     ---
     ```
     - Uses **plain text** (`date: today`) instead of inline R code.
     - Uses `format: html` instead of `output: html_document`.
     - Includes `execute:` options for execution control.

### 4. **Code Execution**
   - **R Markdown**: Uses `knitr` (````{r}` blocks).
   - **Quarto**: Uses Jupyter-like execution and allows **Python, Julia, and JS** alongside R.

### 5. **Table of Contents and Cross-Referencing**
   - **Quarto** natively supports:
     - **Cross-referencing** of figures, tables, equations (`@fig-name`).
     - **More advanced TOC controls**.
   - **R Markdown** requires extra packages like `bookdown` for advanced referencing.

### 6. **Reproducibility Features**
   - **Quarto**: Includes `execute: freeze: auto`, enabling **caching** without external tools.
   - **R Markdown**: Caching is done via **knitr's cache system**, which requires `cache=TRUE` in each chunk.

### 7. **Integration with Jupyter**
   - **Quarto** has **native Jupyter support** and can execute **Python, Julia, and R**.
   - **R Markdown** requires **reticulate** for Python execution and doesn’t support Julia or JS natively.

### 8. **Extensibility**
   - **R Markdown** is heavily tied to the **R ecosystem**.
   - **Quarto** is more **generalized**, allowing broader adoption across different languages and workflows.

### **Summary**
| Feature | R Markdown (`.Rmd`) | Quarto (`.qmd`) |
|---------|----------------|--------------|
| Rendering Engine | `rmarkdown::render()` | `quarto render` |
| Language Support | R (mainly) | R, Python, Julia, JS |
| Output Formats | `html_document`, `pdf_document`, etc. | `format: html`, `format: pdf` |
| YAML Header | `output:` | `format:` |
| Execution | Uses `knitr` | Uses Jupyter-like execution |
| Cross-Referencing | Requires `bookdown` | Built-in |
| Caching | `knitr` caching | `freeze: auto` |

### **Which One to Use?**
- If you are working **only with R** → **Use R Markdown (`.Rmd`)**.
- If you need **multi-language support (R, Python, Julia, JS)** or more flexibility → **Use Quarto (`.qmd`)**.


