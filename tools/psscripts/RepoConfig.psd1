@{
  RepoName = 'system-design-in-practice'

  ExpectedFolders = @(
    'src\01_foundations'
    'src\02_patterns'
    'src\03_distributed-systems'
    'src\04_ai-ml-platforms'
    'src\05_decision-frameworks'
    'src\06_architecture-deep-dives'
    'src\07_case-studies'
    'src\99_interview-qna'
    'docs'
    'tools\psscripts'
  )

  YamlCheckRoots = @(
    'src'
  )

  DisallowInterviewLanguage = $false
}
