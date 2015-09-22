# states switch :
jQuery ($) ->

	$('#medias li').click (e) ->
		e.preventDefault()
		$('#medias li').removeClass 'active'
		$('html').attr('class', '').addClass $(this).data('class')
		$(this).addClass 'active'
		return


	# listen for update in gridle js :
	Gridle.on 'update', (updatedStates, activeStates, unactiveStates) ->
		
		# change state
		# if activeStates[0]?
		# 	$('li[data-state="' + activeStates[0].name + '"]').trigger 'click'
		# else
		# 	$('li[data-state="default"]').trigger 'click'

		# if Gridle.isActive('mobile')
		# 	console.log 'Mobile State Active'
		# return

	# when ready
	Gridle.on 'ready', (e) ->
		states = Gridle.getRegisteredStates()
		$('.grid-12.gridle-debug').each ->
			$this = $(this)
			$ul = $('<ul class="selector selector--states" />')
			$.each states, (idx, item) ->
				$li = $('<li data-state="'+item.name+'">' + item.name + '</li>')
				$li.bind 'click', (e) ->
					$(this).siblings().removeClass 'active'
					$(this).addClass 'active'
					$container = $this
					previous_class = $container.attr('data-active-state')
					$container.removeClass(previous_class).attr 'data-active-state', 'state-' + item.name
					$container.addClass('state-' + item.name) if item.name != 'default'
					return
				$ul.append $li
				$li.trigger('click') if idx is 0
				return
			$this.prepend $ul
			return
		return

	# init gridle
	Gridle.init
		debug: false

	# options
	$('[data-options]').each ->
		$this = $(this)
		$container = $this
		if !$this.hasClass('.gridle-debug')
			$container = $this.closest('.grid-12.gridle-debug')
		options = $this.data('options')
		groups = options.split('|')
		$(groups).each (idx, item) ->
			opts = item.split(',')
			$ul = $('<ul class="selector selector--options" />')
			$.each opts, (idx, item) ->
				$li = $('<li>' + item + '</li>')
				$li.bind 'click', (e) ->
					$(this).siblings().removeClass 'active'
					$(this).addClass 'active'
					previous_class = $(this).parent().attr('data-active')
					$(this).parent().attr 'data-active', item
					$this.removeClass(previous_class).addClass item
					return
				$ul.append $li
				if idx == 0
					$li.trigger 'click'
				return
			$container.prepend $ul
			return
		return
	# $('.container.gridle-debug').each(function() {
	# 	$this = $(this);
	# 	$this.after('<pre />');
	# 	$pre = $this.next('pre');
	# 	$html = $('<div>').append($this.clone());
	# 	html = $('<div/>').text($html.html()).html();
	# 	$pre.html('<code class="language-markup">'+html+'</code>');
	# 	Prism.highlightElement($pre.find('code').get(0));
	# });
	return

# ---
# generated by js2coffee 2.0.4