#!/usr/bin/env nextflow

input_ch = Channel.fromPath(params.input, checkIfExists: true)

process simulate {
  publishDir "results", mode: "copy"

  input:
  file input from input_ch

  output:
  path "cache"

  script:
  if (params.no_gsm)
    """
    julia -t ${params.cpus} -L /data/src/main.jl -e 'main()' $input cache -n ${params.num_epoch} -b ${params.batch_size} --no_gsm
    """
  else
    """
    julia -t ${params.cpus} -L /data/src/main.jl -e 'main()' $input cache -n ${params.num_epoch} -b ${params.batch_size}
    """
}
