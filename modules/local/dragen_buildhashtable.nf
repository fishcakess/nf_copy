process DRAGEN_BUILDHASHTABLE {
    tag "$fasta"
    label 'process_medium'

    input:
    path fasta

    output:
    path "$prefix"     , emit: index
    path "versions.yml", emit: versions

    script:
    def args = task.ext.args ?: ''
    prefix = task.ext.prefix ?: 'dragen'
    """
    /opt/edico/bin/dragen --help

    /opt/edico/bin/dragen --version
    
    mkdir -p $prefix

    /opt/edico/bin/dragen \\
        --build-hash-table true \\
        --output-directory $prefix \\
        --ht-reference $fasta \\
        $args

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        dragen: \$(echo \$(/opt/edico/bin/dragen --version))
    END_VERSIONS
    """
}
