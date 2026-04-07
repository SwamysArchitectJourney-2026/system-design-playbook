@{
  RepoName = 'system-design-in-practice'

  ExpectedFolders = @(
    'src\01_core'
    'src\02_patterns'
    'src\03_systems'
    'src\04_deep-dives'
    'src\05_ai-ml-systems'
    'src\06_decision-trees'
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
