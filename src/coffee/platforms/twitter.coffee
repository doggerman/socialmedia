### Twitter object ###
class Socialmedia.Twitter
	constructor: ->
		@init()
		return @

	### Twitter init method ###
	init: ->
		that = @
		((doc, tag, id) ->
			return if doc.getElementById id
			sdk = doc.createElement tag
			sdk.id = id
			sdk.async = true
			sdk.src = Socialmedia.SDK.twitter
			ref = doc.getElementsByTagName(tag)[0]
			ref.parentNode.insertBefore sdk, ref
			that.twttrsdk = doc.getElementById id
			return
		)(document, 'script', 'twitter-wjs')

	### Twitter share link method ###
	Tweet: (options = { }) ->
		intentShareUrl = '//twitter.com/intent/tweet?'
		data = if options.tweet then "text=#{encodeURIComponent options.tweet}" else "text=#{encodeURIComponent document.title} "
		data += if options.hashtag then "&hashtags=#{encodeURIComponent options.hashtag.replace '/#/', ''} " else ''
		data += if options.recommend then "&related=#{encodeURIComponent options.recommend.replace '/@/', ''} " else ''
		data += if options.via then "&via=#{encodeURIComponent options.via.replace '/@/', ''} " else ''
		data += if options.link then "&url=#{encodeURIComponent options.link} " else "&url=#{encodeURIComponent window.location.href} "
		Socialmedia.Popup.apply @, [intentShareUrl + data]

	### Twitter Follow method ###
	Follow: (username = 'socialmedia_js') ->
		username.replace /@/, ''
		intentFollowUrl = '//twitter.com/intent/follow?'
		Socialmedia.Popup.apply @, [intentFollowUrl + "screen_name=#{username}", 
				width: 700
				height: 485
			]

	###
	# Twitter Mention method
	# Supports multiple recommendations separated by commas
	###
	Mention: (options = { }) ->
		intentMentionUrl = '//twitter.com/intent/tweet?'
		data = options.username and "screen_name=#{encodeURIComponent options.username.replace /@/, ''}" or ''
		data += options.recommend and "&related=#{encodeURIComponent options.recommend.replace /@/, ''}" or ''
		data += options.tweet and "&text=#{encodeURIComponent options.tweet}" or ''
		Socialmedia.Popup.apply @, [intentMentionUrl + data]

	###
	# Twitter Hashtag method
	# Supports multiple recommendations separated by commas
	###
	Hashtag: (options = { }) ->
		intentHashtagUrl = '//twitter.com/intent/tweet?'
		data = options.hashtag and "button_hashtag=#{encodeURIComponent options.hashtag.replace /#/, ''}" or ''
		data += options.recommend and "&related=#{encodeURIComponent options.recommend.replace /@/, ''}" or ''
		data += options.tweet and "&text=#{encodeURIComponent options.tweet}" or ''
		data += options.link and "&url=#{encodeURIComponent options.link}" or ''
		Socialmedia.Popup.apply @, [intentHashtagUrl + data]