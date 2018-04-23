# Sad Joey PowerShell module

## Info

Module compares your level of your sadness with "Sad Joey". #SadJoey is a meme created during [PS Conf 2018](http://www.psconf.eu/). See more info about [#SadJoey](https://twitter.com/hashtag/SadJoey) on Twitter.

Module publishes only one function, **Test-SadJoey** with two parameters:
- [string] **Name** (optional) - your name
- [string] **URL** (mandatory) - public URL to your photo

If you do not have your photo with public URL, you may want to temporary upload your photo online.
For that, you can use one the many [quick photo sharing](https://www.bing.com/search?q=quick+image+sharing) online services. You just need to get direct link to your photo which you can test in your browser.

## In Action

You can see it live in action at https://sadjoey.azurewebsites.net/api/SJ. Or, check a link with [my photo here](https://sadjoey.azurewebsites.net/api/SJ?Name=Igor&URL=http://bitly.com/SJ-Igor) or check [sad Keanu here]().

Or, you can try emotion API on your own [here](https://azure.microsoft.com/en-us/services/cognitive-services/emotion/).

## Application key

Module needs Cognitive services application key. It will prompt you to enter one during import. It can be obtained from [module owner](mailto:iricigor@gmail.com?Subject=TestSadJoeyAppKey).

## Examples

```PowerShell
Test-SadJoey -Name 'Igor' -URL 'http://bit.ly/SJ-Igor'
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
- [x] rotate Sad Igor
- [x] add suggestion where to upload images (temp, free, direct link)
- [x] add Happy Igor, Happy Joey
- [x] add go back link
- [x] resize submitted image to w=320, with keeping aspect
- [x] better Joey result
- [ ] add full switch
- [ ] update examples with correct results, add bitly links