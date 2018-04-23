# Sad Joey PowerShell module

## Info

Module compares your level of sadness with Joey's, meme created during [PS Conf 2018](http://www.psconf.eu/). See more info about [#SadJoey](https://twitter.com/hashtag/SadJoey) on Twitter.

## Application key

Module needs Cognitive services application key. It will prompt you to enter one during import. It can be obtained from [module owner](mailto:iricigor@gmail.com?Subject=TestSadJoeyAppKey).

## Examples

```PowerShell
Test-SadJoey -Name 'Igor' -URL 'http://bit.ly/sadIgor1'
Test-SadJoey -Name 'Keanu' -URL 'http://i0.kym-cdn.com/entries/icons/original/000/002/862/SadKeanu.jpg'
Test-SadJoey -Name 'Igor' -URL 'http://bit.ly/iricigorlinkedinphoto' -Full
```

```
Hi Igor, you are 10 times less sad than Joey.

Hi Keanu, you are 77 percent more sad than Joey.

Hi Igor, here is your emotions report:
not neutral at all
not surprised at all
not afraid at all
not sad at all
not disgusted at all
not angry at all
not despised at all
40117 times more happy than Joey
```

## To-Do list

- [x] create 3 same sized images - Igor, Joey, Keanu
- [x] upload to GitHub
- [ ] read about keys management, how to use it in Azure functions
- [ ] add run.ps1 to GitHub without a key!
- [x] add static home page
