<%
	ui.decorateWith("kenyaui", "panel", [ heading: "Create New Account" ])

	def demographics = [
		[
			[ formFieldName: "personName.givenName", label: "Given Name", class: java.lang.String ],
			[ formFieldName: "personName.familyName", label: "Family Name", class: java.lang.String ]
		],
		[
			ui.decorate("kenyaui", "labeled", [label: "Sex"], """
				<input type="radio" name="gender" value="F" id="gender-F"/>
				<label for="gender-F">Female</label>
				<input type="radio" name="gender" value="M" id="gender-M"/>
				<label for="gender-M">Male</label>
				<span id="gender-F-error" class="error" style="display: none"></span>
				<span id="gender-M-error" class="error" style="display: none"></span>
			""")
		],
		[
			[ formFieldName: "telephone", label: "Telephone contact", class: java.lang.String ]
		]
	]
	
	def providerInfo = [
		[
			[ formFieldName: "providerIdentifier", label: "Provider ID", class: java.lang.String ]
		]
	]
	
	def login = [
		[
			[formFieldName: "username", label: "Username", class: java.lang.String]
		],
		[
			[
					formFieldName: "password",
					label: "Password",
					class: java.lang.String,
					config: [ type: "password" ]
			],
			[
					formFieldName: "confirmPassword",
					label: "Confirm Password",
					class: java.lang.String,
					config: [ type: "password" ]
			]
		],
		[
			[
					formFieldName: "roles",
					label: "Roles",
					class: java.util.List,
					fieldFragment: "field/RoleCollection",
					hideRoles: [ "Anonymous", "Authenticated", "API Privileges", "API Privileges (View and Edit)" ]
			]
		]
	]
%>

<form id="create-account-form" method="post" action="${ ui.actionLink("kenyaemr", "account/newAccount", "createAccount") }">
	<div class="ke-form-globalerrors" style="display: none"></div>

	<fieldset>
		<legend>Person Info</legend>
		<% demographics.each { %>
			${ ui.includeFragment("kenyaui", "widget/rowOfFields", [ fields: it ]) }
		<% } %>
	</fieldset>

	<fieldset>
		<legend>Login Info</legend>
		<% login.each { %>
			${ ui.includeFragment("kenyaui", "widget/rowOfFields", [ fields: it ]) }
		<% } %>
	</fieldset>

	<fieldset>
		<legend>Provider Info</legend>
		<% providerInfo.each { %>
			${ ui.includeFragment("kenyaui", "widget/rowOfFields", [ fields: it ]) }
		<% } %>
	</fieldset>

	<div class="ke-form-footer">
		<button type="submit"><img src="${ ui.resourceLink("kenyaui", "images/glyphs/ok.png") }" /> Create Account</button>
	</div>
</form>

<script type="text/javascript">
	jq(function() {
		kenyaui.setupAjaxPost('create-account-form', {
			onSuccess: function(data) {
				if (data.personId) {
					ui.navigate('kenyaemr', 'admin/manageAccounts');
				} else {
					kenyaui.notifyError('Creating user was successful, but unexpected response');
				}
			}
		});
	});
</script>